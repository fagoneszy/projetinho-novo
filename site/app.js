// site/app.js — busca, filtros e download direto (blob) do BATLAB.
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
    everyday: 'Dia a dia'
  };
  var RISK_LABEL = { low: '🟢 low', medium: '🟡 medium', high: '🔴 high' };

  var state = { tools: [], cat: 'all', q: '', noAdmin: false };

  var $q = document.getElementById('q');
  var $chips = document.getElementById('chips');
  var $grid = document.getElementById('grid');
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

  function filtered() {
    var q = state.q.trim().toLowerCase();
    return state.tools.filter(function (t) {
      if (state.cat !== 'all' && t.category !== state.cat) return false;
      if (state.noAdmin && t.admin) return false;
      if (!q) return true;
      return (t.name + ' ' + t.file + ' ' + t.description + ' ' + t.category)
        .toLowerCase().indexOf(q) !== -1;
    });
  }

  function card(t) {
    var risk = RISK_LABEL[t.risk] || t.risk;
    return '' +
      '<article class="card">' +
        '<h3>' + esc(t.name) + '<span class="ext">.bat</span></h3>' +
        '<p class="desc">' + esc(t.description) + '</p>' +
        '<div class="badges">' +
          '<span class="badge cat">' + esc(CAT_LABELS[t.category] || t.category) + '</span>' +
          '<span class="badge r-' + esc(t.risk) + '">' + esc(risk) + '</span>' +
          (t.admin ? '<span class="badge admin">⚡ admin</span>' : '') +
        '</div>' +
        '<div class="undo"><b>Desfazer:</b> ' + esc(t.undo) + '</div>' +
        '<div class="actions">' +
          '<a class="btn dl" href="' + esc(t.download) + '" data-dl="1">Download</a>' +
          '<a class="btn src" href="' + esc(t.source) + '" target="_blank" rel="noopener">Código</a>' +
        '</div>' +
      '</article>';
  }

  function render() {
    var list = filtered();
    $grid.innerHTML = list.map(card).join('');
    $empty.hidden = list.length !== 0;
    $count.textContent = list.length + ' de ' + state.tools.length + ' ferramentas';
  }

  function renderChips() {
    var counts = {};
    state.tools.forEach(function (t) {
      counts[t.category] = (counts[t.category] || 0) + 1;
    });
    var cats = Object.keys(CAT_LABELS).filter(function (c) { return counts[c]; });
    var html = '<span class="chip active" data-cat="all">Todas <span class="n">(' +
      state.tools.length + ')</span></span>';
    html += cats.map(function (c) {
      return '<span class="chip" data-cat="' + esc(c) + '">' +
        esc(CAT_LABELS[c]) + ' <span class="n">(' + counts[c] + ')</span></span>';
    }).join('');
    $chips.innerHTML = html;
    Array.prototype.forEach.call($chips.querySelectorAll('.chip'), function (el) {
      el.addEventListener('click', function () {
        Array.prototype.forEach.call($chips.querySelectorAll('.chip'), function (c) {
          c.classList.remove('active');
        });
        el.classList.add('active');
        state.cat = el.getAttribute('data-cat');
        render();
      });
    });
  }

  function renderStats() {
    var admin = 0, high = 0;
    state.tools.forEach(function (t) {
      if (t.admin) admin++;
      if (t.risk === 'high') high++;
    });
    $stats.innerHTML =
      '<span class="stat"><b>' + state.tools.length + '</b> ferramentas</span>' +
      '<span class="stat"><b>11</b> categorias</span>' +
      '<span class="stat"><b>' + admin + '</b> pedem admin</span>' +
      '<span class="stat"><b>' + high + '</b> de risco alto</span>';
  }

  // Download real via blob (raw.githubusercontent.com e cross-origin ignoram
  // o atributo download; fetch + blob resolve e mantem o "direto sem pagina").
  $grid.addEventListener('click', function (ev) {
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

  $q.addEventListener('input', function () { state.q = $q.value; render(); });
  $noAdmin.addEventListener('change', function () {
    state.noAdmin = $noAdmin.checked;
    render();
  });

  fetch('projects.json')
    .then(function (r) { return r.json(); })
    .then(function (data) {
      state.tools = data;
      renderStats();
      renderChips();
      render();
    })
    .catch(function () {
      $empty.hidden = false;
      $empty.textContent = 'Erro ao carregar projects.json — rode: powershell -File tools\\build-manifest.ps1';
    });
})();
