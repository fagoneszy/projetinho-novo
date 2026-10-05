# Regras de banco de dados

Banco: **Neon PostgreSQL** (Free: 1 GB por projeto — folga enorme para ≥10.000 registros).
ORM: **Drizzle** (`web/drizzle/`). Validação de borda: **Zod**. Migrations: **drizzle-kit**.

## Regras inegociáveis

- **Nunca** armazenar arquivos (`.bat`, `.sh`, binários, zip) no PostgreSQL. Apenas
  metadados. Download sempre vem do GitHub Releases via `download_url`.
- `DATABASE_URL` é **segredo de servidor**. Nunca em `NEXT_PUBLIC_*`, nunca em
  `client component`, nunca em log.
- Todo schema novo/mudança de schema passa por migration do drizzle-kit
  (`npx drizzle-kit generate` → SQL versionado em `web/drizzle/`). Proibido rodar
  `ALTER`/`CREATE` ad-hoc em produção sem migration.
- `slug` é **único**, em minúsculas e **sem hífen** (ex.: `folderorganizer`) — ver
  `content-model.md`. Validação: `^[a-z0-9]+$`.
- Toda ferramenta tem `license` (padrão `MIT`), `platform` (pelo menos uma) e
  `risk_level` declarados. Toda operação privilegiada declara `requires_admin`.
  Toda operação destrutiva declara `deletes` diferente de `none`.
- Seed **idempotente**: upsert por `slug`; nunca duplicar; nunca apagar em massa sem
  flag explícita.

## Schema (drizzle-orm/pg-core)

```text
categories        id, slug, name, description, icon, parent_id?
scripts           id, slug, name, description, long_description?, status,
                  license, risk_level, requires_admin, writes, deletes,
                  registry, services, tasks, network, restart,
                  undo?, current_version, created_at, updated_at
platforms         id, name, slug                     (windows|linux|macos|android)
script_platforms  script_id, platform_id             (PK composta)
tags              id, name, slug
script_tags       script_id, tag_id                  (PK composta)
releases          id, script_id, version, download_url, source_url,
                  sha256, file_size, released_at
problems          id, slug, title, description, keywords[], position
problem_tools     problem_id, script_id, position    (PK composta)
downloads_daily   script_id, date, count             (PK: script_id+date)
```

### Enums exatos (fiel ao cabeçalho de segurança v2)

- `risk_level`: `low | medium | high | critical`
- `writes`: `none | temp | user | system`
- `deletes`: `none | temp | files`
- `registry`, `services`, `tasks`, `network`: `none | read | write`
- `restart`: `none | process | explorer | os`

Os booleans derivados (ex.: `network_access`) podem ser **generated columns** ou views;
a fonte é o enum, não o contrário. Motivo: o site v2 já publica esses 7 campos como
chips — perder a granularidade quebraria os chips do catálogo.

### Relações

- `scripts.category_id → categories.id` (1:N; `@category` do cabeçalho = slug da pasta)
- N:N via `script_platforms` e `script_tags`
- `releases` 1:N por script; `scripts.current_version` aponta a vigente
- `problems` × `scripts` N:N via `problem_tools` (spéc dos JSONs em `problems/`)
- **Não** existe tabela de download individual — só `downloads_daily` agregado

## Seed

- Comando: `npm run seed` em `web/` → lê `../site/projects.json` e `../problems/*.json`
- Upsert por `slug`; preenche `releases` inicial (version `1.0.0`, `sha256` de
  `SHA256SUMS.txt`, `download_url` de release/raw — ver `workflows/release-tool.md`)
- Roda localmente e em CI; precisa de `DATABASE_URL` no ambiente
