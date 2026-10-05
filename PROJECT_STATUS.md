# BATLAB - Status do Projeto

## Objetivo atual
Construir plataforma BATLAB completa (Next.js + Neon PostgreSQL + Drizzle + comunidade + moderação + catálogo de ferramentas) com leadpage dark minimal centralizada e ondas orgânicas, mantendo em paralelo a Fase 1 de geração de `.bat` Windows. Scripts permanecem módulo; nunca armazenar executáveis no banco, apenas metadados e distribuição via GitHub Releases.

## Contexto / Decisões tomadas
- Stack aprovada: Vercel Next.js App Router, TypeScript, Tailwind, shadcn/ui, Motion; Neon PostgreSQL; Drizzle ORM; Zod; Google OAuth primário; GitHub Releases para distribuição.
- `.agents/` versionado (`.gitignore` corrigido). Fundação commitada `5670638` com `architecture.md`, `database.md`, `security.md`, `coding-standards.md`, `ui.md`, `seo.md`, `content-model.md`, `workflows/*`, skills `batlab-schema` e `batlab-secure-app`.
- Estratégia: Paralelo (C) — subagente gera lotes em background enquanto app avança.
- MVP enxuto: leadpage + Google OAuth + catálogo.
- Site v2 estático fica intocado.
- Regras BATLAB mantidas: metadata v2, slug BaseName minúsculo sem hífen, `::`/`#` nos primeiros 30 lines, CRLF UTF-8 sem BOM, PS com aspas simples internas, risk/admin/writes/registry serviços/tasks/network/restart.
- Segurança plataforma: roles USER/MODERATOR/ADMIN/OWNER; status ACTIVE/SUSPENDED/BANNED/DELETED; auth server-side, Server Actions como endpoints públicos, Zod em toda fronteira, allowlist de downloads, audit_logs, rate limiting, CSRF/CSP/HSTS.

## Estado do Trabalho

### Concluído
- Fase 0 concluída; site v2 com 3 portas, 17 problemas, 3 plataformas.
- Fase 1 lote 1 `a376548`: `windows/batch/system-diagnosis/` 24 ferramentas.
- Fase 1 lote 2 `c0da54f`: `windows/batch/windows-update/` 24 ferramentas (reset do incidente `95f6d73`).
- Fase 1 lote 3 `3f48b7c`: `windows/batch/storage-advanced/` 22 ferramentas → 380 ferramentas.
- Fase 1 lote 4 `6b841ae`: `windows/batch/network-advanced/` 30 ferramentas → 410 ferramentas no manifest.
  - Distribuição lote4: 23 low, 6 medium, 1 high; admin no 26, yes 4.
  - README gerado, catálogo anotado `impl-f1`, problema `rede-problemas.json` atualizado (+16 slugs).
- `.agents` fundação commitada; `tools/build-readmes.ps1` atualizado com `network-advanced` e `security-audit`.
- Build ok: `tools/build-manifest.ps1` 410 ferramentas Windows, `tools/build-readmes.ps1` 405 README Windows, `tools/build-problems.ps1` 17 problemas.

### Em andamento
- **Lote 5 sec5 security-audit (29 ferramentas)**: pasta `windows/batch/security-audit/` criada, arquivos vazios presentes. Build-manifest conta 29 mas faltam cabeçalhos v2. Testes ao vivo indicam admin yes para `UnsignedDriverReport`, `AccountLockoutReport`, `FailedLoginReport`, `RecentLoginReport`, `SecurityLogSummary`, `AuditPolicyReport`, `SecureBootStatus`, `BitLockerStatus`, `DeviceEncryptionStatus`, `SecurityPostureReport`, `SecuritySnapshot`. Em produção.
- **.agents completo**: expandir para ~15 skills + `AGENTS.md` roteador.
- **Web/**: scaffold Next.js + TS + Tailwind + shadcn + Motion pendente.
- Leadpage centrada dark com ondas orgânicas (P1), Auth Google OAuth + roles (P2), Catálogo /tools (P3).
- Lotes seguintes sec6+ alternando com app.

### Bloqueado / Pendências
- security-audit: arquivos precisam de conteúdo com cabeçalho v2, PS parseável, CRLF sem BOM. Rate limit impediu subagente; geração manual pendente.
- `tools/build-readmes.ps1` precisa manter categorias novas sincronizadas.
- `problems/rede-problemas.json` contém slugs adicionais que ainda não aparecem no site até os arquivos serem escritos.

## Próximos Passos
1. Finalizar lote 5 security-audit 29 ferramentas com cabeçalho v2 completo, teste ao vivo de admin, build-manifest 410→439, README, catálogo `impl-f1`, atualizar `seguranca.json` problema.
2. Expandir `.agents` para conjunto completo de skills + `AGENTS.md` roteador de segurança/comunidade/moderação/UX.
3. Scaffold `web/` Next.js App Router com leadpage dark centralizada, ondas orgânicas, Google OAuth, catálogo de ferramentas consumindo `site/projects.json`/`Neon`.
4. Despachar lote 6 em paralelo (sec6) via subagente com proibição `git commit`.
5. Integrar distribuição via GitHub Releases, políticas de moderação, e auditoria.

## Arquivos relevantes
- `C:\Users\faguinho\Documents\projetinho novo\.agents\` — regras + skills
- `windows/batch/system-diagnosis/`, `windows-update/`, `storage-advanced/`, `network-advanced/`, `security-audit/`
- `docs/catalog-v2.csv`
- `site/projects.json`, `site/problems.json`
- `problems/*.json`
- `tools/build-manifest.ps1`, `build-readmes.ps1`, `build-problems.ps1`
- Commits recentes: `6b841ae`, `5670638`, `3f48b7c`, `c0da54f`, `a376548`

## Métricas atuais
- Ferramentas Windows no manifest: 439 (contando security-audit vazios)
- Ferramentas implantadas válidas: 410
- Categorias ativas: automation 30, customization 25, developer 30, diagnostics 20, emergency 1, everyday 20, files 30, games 30, media 25, network 30, network-advanced 30, privacy 1, productivity 30, security-audit 29, storage-advanced 23, system 35, system-diagnosis 25, windows-update 25
- Problemas: 17
