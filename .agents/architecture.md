# Arquitetura BATLAB

## O que é o BATLAB

Catálogo multiplataforma de microutilitários `.bat` / `.sh` (alvo: 957 ferramentas) com
metadados de segurança por ferramenta, taxonomia de 17 problemas do usuário e site de
catálogo. Hoje: 380 ferramentas implementadas (fase 1 em andamento).

## Stack definitiva

```text
Usuário → Vercel (Next.js + React + TypeScript + Tailwind + shadcn/ui + Motion)
                │
                ├── Neon (PostgreSQL)  → catálogo: metadados de todas as ferramentas
                │                         (Drizzle ORM + Zod, migrations via drizzle-kit)
                └── GitHub              → código-fonte + Releases (downloads dos arquivos)
```

- **Nunca** guardar arquivos executáveis/`.bat`/`.sh` no PostgreSQL. O banco guarda
  **somente metadados**; os arquivos ficam no repositório e são distribuídos por
  **GitHub Releases** (`download_url` + `sha256` na tabela `releases`).
- Auth pública: nenhuma. Só `/admin` é autenticado (gate por env no início; Better Auth
  quando o admin amadurecer).
- CDN/DNS Cloudflare: fase posterior, não bloqueia nada agora.

## Layout do repositório (monorepo)

```text
/ (raiz)        catálogo de ferramentas e site estático atual
├── windows|linux|macos|android/   ferramentas por plataforma
├── tools/                         build-manifest, build-readmes, build-problems, seed
├── docs/                          catalog-v2.csv, TEMPLATE.md, RISCOS.md
├── problems/                      17 JSONs da taxonomia de problemas
├── site/                          site estático v2 — INTOCADO até o app v3 substituí-lo
├── web/                           app Next.js (src/, drizzle/, scripts/)
└── .agents/                       este diretório: regras + skills do agente
```

Regras de convivência:

- `site/` (estático) continua funcionando como fallback/possível GitHub Pages. O app em
  `web/` é o v3 e **não deve alterar nem remover** `site/` até estar pronto em produção.
- Fonte de verdade do catálogo **hoje** é `site/projects.json` (gerado por
  `tools/build-manifest.ps1` a partir dos cabeçalhos `::`/`#` das ferramentas). O seed do
  Neon lê esse JSON. Quando o admin CRUD existir, o banco passa a ser fonte para o app e o
  JSON continua sendo gerado para o site estático.
- Todo trabalho de ferramentas novas segue os lotes da fase 1
  (`BATLAB fase 1 lote N: <categoria> (<n> ferramentas)`).

## Fluxo de dados

```text
cabeçalho ::/# da ferramenta
   → build-manifest → site/projects.json + SHA256SUMS.txt
   → seed (web/scripts/seed.ts) → Neon: scripts/releases/…
   → app Next.js lê do banco → páginas públicas
   → download_url → GitHub Release → arquivo .bat/.sh
```

## Onde ler antes de codar

1. `.agents/database.md` — schema e regras do banco
2. `.agents/security.md` — regras de segurança da aplicação
3. `.agents/content-model.md` — entidades de conteúdo e slug
4. `.agents/workflows/` — fluxos: add-tool, update-tool, release-tool, migrate-tool
5. Skills: `.agents/skills/batlab-schema/` e `.agents/skills/batlab-secure-app/`
