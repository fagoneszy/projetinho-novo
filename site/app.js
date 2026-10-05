// site/app.js — BATLAB v2: tres portas (problema/categoria/plataforma),
// busca, filtros, risco v2 (critical + confirm), SHA-256 e download (blob).
(function () {
  'use strict';

  var CAT_LABELS = {
    productivity: 'Produtividade',
    files: 'Arquivos',
    system: 'Sistema',
    network: 'Rede',
    developer: 'Dev',
    media: 'Mídia',
    customization: 'Custom',
    games: 'Jogos',
    automation: 'Automação',
    diagnostics: 'Diagnóstico',
    everyday: 'Dia a dia',
    'system-diagnosis': 'Diagnóstico de sistema',
    'windows-update': 'Windows Update',
    'storage-advanced': 'Armazenamento avançado',
    'network-advanced': 'Rede avançada',
    'security-audit': 'Auditoria de segurança',
    privacy: 'Privacidade',
    'identity-access': 'Identidade e acesso',
    'process-services': 'Processos e serviços',
    workspaces: 'Áreas de trabalho',
    'git-advanced': 'Git avançado',
    'dev-toolchains': 'Toolchains de dev',
    'containers-wsl': 'Containers e WSL',
    'backup-advanced': 'Backup avançado',
    'data-files': 'Dados e arquivos',
    peripherals: 'Periféricos',
    devops: 'DevOps',
    observability: 'Observabilidade',
    'media-advanced': 'Mídia avançada',
    'power-user': 'Power user',
    'fun-terminal': 'Diversão no terminal',
    'content-creation': 'Criação de conteúdo',
    'why-troubleshoot': 'Por que não funciona',
    'vuln-audit': 'Vulnerabilidades',
    checklists: 'Checklists',
    provisioning: 'Provisionamento',
    migration: 'Migração',
    emergency: 'Emergência'
  };
  var PLAT_LABELS = { windows: 'Windows', linux: 'Linux', macos: 'macOS', android: 'Android' };
  var RISK_LABEL = {
    low: '\u{1F7E2} low',
    medium: '\u{1F7E1} medium',
    high: '\u{1F534} high',
    critical: '\u26AB critical'
  };

  var state = {
    tools: [], problems: [], bySlug: {},
    view: 'problems', cat: 'all', plat: 'all',
    open: null, q: '', noAdmin: false
  };

  var $q = document.getElementById('q');
  var $doors = document.getElementById('doors');
  var $chips = document.getElementById('chips');
  var $grid = document.getElementById('grid');
  var $plist = document.getElementById('problems');
  var $count = document.getElementById('count');
  var $empty = document.getElementById('empty');
  var $stats = document.getElementById('stats');
  var $noAdmin = document.getElementById('noAdmin');
  var $toast = document.getElementById('toast');

  if (typeof REPO_OWNER !== 'undefined') {
    var rl = document.getElementById('repo-link');
    rl.href = 'https://github.com/' + REPO_OWNER + '/' + REPO_NAME;
    rl.textContent = 'github.com/' + REPO_OWNER + '/' + REPO_NAME;
  }

  function esc(s) {
    return String(s == null ? '' : s)
      .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;');
  }

  function toast(msg) {
    $toast.textContent = msg;
    $toast.hidden = false;
    clearTimeout(toast._t);
    toast._t = setTimeout(function () { $toast.hidden = true; }, 2600);
  }

  function matches(t, q) {
    return (t.name + ' ' + t.file + ' ' + t.description + ' ' +
      t.category + ' ' + t.platform).toLowerCase().indexOf(q) !== -1;
  }

  /* ---------- hash / deep-link ---------- */

  function serialize() {
    var h = 'v=' + state.view;
    if (state.view === 'problems' && state.open) h += '&p=' + state.open;
    if (state.view === 'cats' && state.cat !== 'all') h += '&c=' + state.cat;
    if (state.view === 'platforms' && state.plat !== 'all') h += '&pl=' + state.plat;
    return h;
  }

  function syncHash() {
    var h = '#' + serialize();
    if (('#' + (location.hash.replace(/^#/, ''))) !== h) {
      history.replaceState(null, '', h);
    }
  }

  function parseHash() {
    var raw = location.hash.replace(/^#/, '');
    if (!raw) return null;
    var out = {};
    raw.split('&').forEach(function (kv) {
      var i = kv.indexOf('=');
      if (i > 0) out[kv.slice(0, i)] = decodeURIComponent(kv.slice(i + 1));
    });
    if (out.v === 'problems' || out.v === 'cats' || out.v === 'platforms') {
      state.view = out.v;
    }
    if (state.view === 'cats' && out.c) state.cat = out.c;
    if (state.view === 'platforms' && out.pl) state.plat = out.pl;
    return state.view === 'problems' && out.p ? out.p : null;
  }

  /* ---------- cards ---------- */

  function secChips(t) {
    var out = [];
    if (t.writes && t.writes !== 'none') out.push('grava: <b>' + esc(t.writes) + '</b>');
    if (t.deletes && t.deletes !== 'none') out.push('apaga: <b>' + esc(t.deletes) + '</b>');
    if (t.registry && t.registry !== 'none')
      out.push('registro: <b>' + (t.registry === 'write' ? 'grava' : 'leitura') + '</b>');
    if (t.services && t.services !== 'none')
      out.push('serviços: <b>' + (t.services === 'write' ? 'grava' : 'leitura') + '</b>');
    if (t.tasks && t.tasks !== 'none')
      out.push('tarefas: <b>' + (t.tasks === 'write' ? 'grava' : 'leitura') + '</b>');
    if (t.network && t.network !== 'none')
      out.push('rede: <b>' + (t.network === 'write' ? 'grava' : 'leitura') + '</b>');
    if (t.restart && t.restart !== 'none') out.push('reinicia: <b>' + esc(t.restart) + '</b>');
    if (!out.length) return '';
    return '<div class="sec">' + out.map(function (c) {
      return '<span class="sec-chip">' + c + '</span>';
    }).join('') + '</div>';
  }

  function card(t) {
    var risk = RISK_LABEL[t.risk] || t.risk;
    var ext = /\.sh$/i.test(t.file) ? '.sh' : '.bat';
    var sha = t.sha256 ? t.sha256.slice(0, 16) + '…' : '';
    return '' +
      '<article class="card">' +
        '<h3>' + esc(t.name) + '<span class="ext">' + ext + '</span></h3>' +
        '<p class="desc">' + esc(t.description) + '</p>' +
        '<div class="badges">' +
          '<span class="badge plat">' + esc(PLAT_LABELS[t.platform] || t.platform) + '</span>' +
          '<span class="badge cat">' + esc(CAT_LABELS[t.category] || t.category) + '</span>' +
          '<span class="badge r-' + esc(t.risk) + '">' + esc(risk) + '</span>' +
          (t.admin ? '<span class="badge admin">⚡ admin</span>' : '') +
          (t.confirm ? '<span class="badge confirm">⌨ confirmação: ' + esc(t.confirm) + '</span>' : '') +
        '</div>' +
        secChips(t) +
        '<div class="undo"><b>Desfazer:</b> ' + esc(t.undo) + '</div>' +
        (sha ? '<div class="hash" data-hash="' + esc(t.sha256) + '" ' +
          'title="SHA-256 — clique para copiar">sha256: ' + esc(sha) + '</div>' : '') +
        '<div class="actions">' +
          '<a class="btn dl" href="' + esc(t.download) + '" data-dl="1">Download</a>' +
          '<a class="btn src" href="' + esc(t.source) + '" target="_blank" rel="noopener">Código</a>' +
        '</div>' +
      '</article>';
  }

  /* ---------- render: stats / chips / portas ---------- */

  function renderStats() {
    var admin = 0, high = 0, crit = 0;
    var plats = {}, cats = {};
    state.tools.forEach(function (t) {
      if (t.admin) admin++;
      if (t.risk === 'high') high++;
      if (t.risk === 'critical') crit++;
      plats[t.platform] = true;
      cats[t.category] = true;
    });
    var nPlats = Object.keys(plats).length;
    var nPlatsAll = Object.keys(PLAT_LABELS).length;
    var s = '' +
      '<span class="stat"><b>' + state.tools.length + '</b> ferramentas</span>' +
      '<span class="stat"><b>' + Object.keys(cats).length + '</b> categorias</span>' +
      '<span class="stat"><b>' + nPlats + '/' + nPlatsAll + '</b> plataformas</span>' +
      '<span class="stat"><b>' + state.problems.length + '</b> problemas</span>' +
      '<span class="stat"><b>' + admin + '</b> pedem admin</span>' +
      '<span class="stat"><b>' + high + '</b> risco alto' +
      (crit ? ' · <b>' + crit + '</b> crítico' : '') + '</span>';
    $stats.innerHTML = s;
  }

  function renderDoors() {
    Array.prototype.forEach.call($doors.querySelectorAll('.door'), function (el) {
      el.classList.toggle('active', el.getAttribute('data-view') === state.view);
    });
  }

  function renderChips() {
    if (state.view === 'problems') { $chips.innerHTML = ''; return; }
    var counts = {}, order = [];
    state.tools.forEach(function (t) {
      if (!counts[t.category]) order.push(t.category);
      counts[t.category] = (counts[t.category] || 0) + 1;
    });
    var html = '';
    if (state.view === 'cats') {
      html = '<span class="chip' + (state.cat === 'all' ? ' active' : '') +
        '" data-cat="all">Todas <span class="n">(' + state.tools.length + ')</span></span>';
      html += order.map(function (c) {
        return '<span class="chip' + (state.cat === c ? ' active' : '') +
          '" data-cat="' + esc(c) + '">' + esc(CAT_LABELS[c] || c) +
          ' <span class="n">(' + counts[c] + ')</span></span>';
      }).join('');
    } else {
      var pc = {};
      state.tools.forEach(function (t) { pc[t.platform] = (pc[t.platform] || 0) + 1; });
      html = '<span class="chip' + (state.plat === 'all' ? ' active' : '') +
        '" data-plat="all">Todas <span class="n">(' + state.tools.length + ')</span></span>';
      html += Object.keys(PLAT_LABELS).map(function (p) {
        var n = pc[p] || 0;
        var cls = 'chip';
        if (n === 0) cls += ' disabled';
        else if (state.plat === p) cls += ' active';
        return '<span class="' + cls + '" data-plat="' + p + '">' +
          esc(PLAT_LABELS[p]) + ' <span class="n">(' + n + ')</span></span>';
      }).join('');
    }
    $chips.innerHTML = html;
  }

  /* ---------- render: vistas ---------- */

  function baseTools() {
    var list = state.tools;
    if (state.noAdmin) list = list.filter(function (t) { return !t.admin; });
    if (state.view === 'cats' && state.cat !== 'all') {
      list = list.filter(function (t) { return t.category === state.cat; });
    }
    if (state.view === 'platforms' && state.plat !== 'all') {
      list = list.filter(function (t) { return t.platform === state.plat; });
    }
    var q = state.q.trim().toLowerCase();
    if (q) list = list.filter(function (t) { return matches(t, q); });
    return list;
  }

  function renderGrid() {
    var list = baseTools();
    $grid.innerHTML = list.map(card).join('');
    $count.textContent = list.length + ' de ' + state.tools.length + ' ferramentas';
    $empty.hidden = list.length !== 0;
    $empty.textContent = 'Nada encontrado. Tente outra palavra.';
  }

  function renderProblems() {
    var q = state.q.trim().toLowerCase();
    var html = [];
    var nShown = 0;
    state.problems.forEach(function (p) {
      var mapped = [];
      p.tools.forEach(function (slug) {
        var t = state.bySlug[slug];
        if (t) mapped.push(t);
      });
      if (state.noAdmin) mapped = mapped.filter(function (t) { return !t.admin; });
      var meta = (p.title + ' ' + p.desc + ' ' + p.keywords.join(' ')).toLowerCase();
      var metaHit = !q || meta.indexOf(q) !== -1;
      var toolsHit = q ? mapped.filter(function (t) { return matches(t, q); }) : mapped;
      if (q && !metaHit && toolsHit.length === 0) return;
      var visible = (q && !metaHit) ? toolsHit : mapped;
      var open = state.open === p.id;
      nShown++;
      html.push(
        '<article class="pcard' + (open ? ' open' : '') + '" data-pid="' + esc(p.id) + '">' +
          '<div class="phead">' +
            '<span class="pnum">#' + p.order + '</span>' +
            '<h2>' + esc(p.title) + '</h2>' +
            '<span class="pcount">' + visible.length + ' ferramenta' +
              (visible.length === 1 ? '' : 's') + (open ? ' ▲' : ' ▼') + '</span>' +
          '</div>' +
          '<p class="pdesc">' + esc(p.desc) + '</p>' +
          '<p class="pkeys">' + p.keywords.map(function (k) {
            return '<span>' + esc(k) + '</span>';
          }).join('') + '</p>' +
          (open ?
            '<div class="pbody">' +
              (state.noAdmin ? '<p class="sub">filtros ativos aplicados à lista abaixo</p>' : '') +
              (visible.length ?
                '<div class="grid">' + visible.map(card).join('') + '</div>' :
                '<p class="sub">Nenhuma ferramenta aqui com os filtros atuais.</p>') +
            '</div>' : '') +
        '</article>'
      );
    });
    $plist.innerHTML = html.join('');
    $count.textContent = nShown + ' de ' + state.problems.length + ' problemas';
    $empty.hidden = nShown !== 0;
    $empty.textContent = 'Nenhum problema com essa busca. Tente outra palavra.';
  }

  function renderAll() {
    renderDoors();
    renderChips();
    if (state.view === 'problems') {
      $grid.innerHTML = '';
      renderProblems();
    } else {
      $plist.innerHTML = '';
      renderGrid();
    }
    syncHash();
  }

  /* ---------- eventos ---------- */

  $doors.addEventListener('click', function (ev) {
    var b = ev.target.closest ? ev.target.closest('.door') : null;
    if (!b) return;
    state.view = b.getAttribute('data-view');
    renderAll();
  });

  $chips.addEventListener('click', function (ev) {
    var el = ev.target.closest ? ev.target.closest('.chip') : null;
    if (!el || el.classList.contains('disabled')) return;
    if (el.hasAttribute('data-cat')) state.cat = el.getAttribute('data-cat');
    if (el.hasAttribute('data-plat')) state.plat = el.getAttribute('data-plat');
    renderAll();
  });

  $plist.addEventListener('click', function (ev) {
    var head = ev.target.closest ? ev.target.closest('.phead') : null;
    if (head) {
      var cardEl = head.closest('.pcard');
      var pid = cardEl.getAttribute('data-pid');
      state.open = state.open === pid ? null : pid;
      renderAll();
    }
  });

  // copiar SHA-256
  document.addEventListener('click', function (ev) {
    var h = ev.target.closest ? ev.target.closest('.hash') : null;
    if (!h) return;
    var val = h.getAttribute('data-hash');
    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(val).then(
        function () { toast('SHA-256 copiado.'); },
        function () { toast('Não deu para copiar — o texto está selecionável.'); }
      );
    } else {
      toast('Selecione e Ctrl+C — hash pronto.');
    }
  });

  // download real via blob (raw.githubusercontent.com e cross-origin ignoram
  // o atributo download; fetch + blob resolve e mantem o "direto sem pagina").
  document.addEventListener('click', function (ev) {
    var a = ev.target.closest ? ev.target.closest('a[data-dl]') : null;
    if (!a) return;
    ev.preventDefault();
    var url = a.getAttribute('href');
    var fname = url.split('/').pop();
    fetch(url)
      .then(function (r) {
        if (!r.ok) throw new Error('HTTP ' + r.status);
        return r.blob();
      })
      .then(function (b) {
        var u = URL.createObjectURL(b);
        var t = document.createElement('a');
        t.href = u;
        t.download = fname;
        document.body.appendChild(t);
        t.click();
        t.remove();
        setTimeout(function () { URL.revokeObjectURL(u); }, 4000);
        toast('Baixando ' + fname + ' …');
      })
      .catch(function () {
        window.open(url, '_blank', 'noopener');
        toast('Abriu o arquivo — salve com Ctrl+S.');
      });
  });

  $q.addEventListener('input', function () { state.q = $q.value; renderAll(); });
  $noAdmin.addEventListener('change', function () {
    state.noAdmin = $noAdmin.checked;
    renderAll();
  });

  window.addEventListener('hashchange', function () {
    parseHash();
    renderAll();
  });

  /* ---------- boot ---------- */

  var pendingOpen = parseHash();

  Promise.all([fetch('projects.json'), fetch('problems.json')])
    .then(function (rs) {
      return Promise.all(rs.map(function (r) {
        if (!r.ok) throw new Error('HTTP ' + r.status);
        return r.json();
      }));
    })
    .then(function (data) {
      state.tools = data[0];
      state.problems = data[1];
      state.bySlug = {};
      state.tools.forEach(function (t) { state.bySlug[t.slug] = t; });
      if (pendingOpen) {
        var found = state.problems.some(function (p) { return p.id === pendingOpen; });
        if (found) state.open = pendingOpen;
      }
      renderStats();
      renderAll();
    })
    .catch(function () {
      $empty.hidden = false;
      $empty.textContent = 'Erro ao carregar os JSONs — rode: powershell -File tools\\build-manifest.ps1 e tools\\build-problems.ps1';
    });
})();
