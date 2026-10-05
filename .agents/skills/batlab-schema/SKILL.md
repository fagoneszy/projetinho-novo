---
name: batlab-schema
description: Use when creating or changing the BATLAB database schema, Drizzle tables/enums, migrations (drizzle-kit), the seed script (site/projects.json ou problems/*.json → Neon), relations between scripts/categories/platforms/tags/releases/problems, or when validating that metadata v2 fields (@risk/@admin e os 7 campos de segurança) are faithfully represented in PostgreSQL. Also use for any raw SQL or data backfill on the BATLAB Neon database.
---

# BATLAB Schema (Drizzle + Neon)

Fonte de verdade das regras: `.agents/database.md`. Este skill operationaliza aquilo —
leia o arquivo antes de uma mudança grande.

## Regras que nunca se quebram

1. **Metadados só.** Nenhum `.bat`/`.sh`/binário no banco. Downloads via `download_url`
   (GitHub Releases).
2. **Enums exatos do cabeçalho v2** — `risk_level`, `writes`, `deletes`, `registry`,
   `services`, `tasks`, `network`, `restart`. Não substituir por boolean quando o
   cabeçalho distingue `read`/`write` ou `temp`/`user`/`system`.
3. **`slug` = BaseName minúsculo SEM hífen** (`folderorganizer`), `^[a-z0-9]+$`,
   unique. Proibido "padronizar" para hífen.
4. Toda mudança de schema = migration gerada e revisada:

```bash
cd web
npx drizzle-kit generate     # gera SQL versionado
npx drizzle-kit migrate      # aplica (DATABASE_URL no .env.local)
```

Nunca `ALTER TABLE` ad-hoc em produção.

## Checklist de uma migration

- [ ] Schema Drizzle (`web/drizzle/schema.ts`) e SQL gerado batem
- [ ] Enums/`check` com os valores exatos; `slug` unique
- [ ] FKs: `releases→scripts`, `problem_tools→problems/scripts`, `script_*` N:N
- [ ] Sem `DROP` de tabela com dados sem aprovação explíciva (deprecar = `status`)
- [ ] Seed continua idempotente (upsert por slug) e roda após a migration
- [ ] `npm run typecheck` limpo

## Seed (`web/scripts/seed.ts`)

- Lê `../site/projects.json` (gerado por `tools/build-manifest.ps1`) e
  `../problems/*.json` — nunca editar esses JSONs na mão para "consertar" o banco.
- Upsert por slug nos domínios: `scripts`, `categories`, `platforms`, `tags`,
  `problems`; `problem_tools` reescrito na ordem do array `tools`.
- `releases` inicial: `version` do cabeçalho (`v1.0.0`), `sha256` de `SHA256SUMS.txt`,
  `download_url` raw até a primeira release (release-tool.md).
- Nunca DELETE em massa; ferramenta ausente do JSON vira `deprecated`, não some.

## Ao escrever query bruta (route handler/servidor)

- Sempre parameterizada (`sql` template do drizzle ou `$1`), nunca interpolação de input.
- Upsert de contadores: `onConflictDoUpdate` em `downloads_daily` (`script_id+date`).
