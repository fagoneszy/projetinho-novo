# Modelo de conteúdo

## Fonte de verdade

| Quando | Fonte do catálogo |
|---|---|
| Agora (fase 1) | Cabeçalhos `::`/`#` das ferramentas → `site/projects.json` (build-manifest) → seed do banco |
| Depois do admin | Banco (Neon) → admin CRUD; `build-manifest` continua gerando o JSON para o `site/` estático |
| Arquivos | GitHub (código) + GitHub Releases (downloads) — nunca o banco |

## Slug — regra de ouro

```text
slug = BaseName do arquivo, minúsculo, SEM hífen
FolderOrganizer.bat → folderorganizer
```

- Validação: `^[a-z0-9]+$`, único.
- **Não** migrar para `folder-organizer`: os 17 JSONs de `problems/*.json`, os anchors do
  `site/` e 380 entradas existentes usam o formato sem hífen. Mudar = quebra geral.
- Renomear slug exige redirect e atualização em problems/READMEs (migrate-tool.md).

## Entidades

- **Script (ferramenta)** — nome de arquivo (exibição), slug, descrição (`@desc`),
  categoria (= pasta), plataforma(s), versão atual, licença (MIT), status
  (`active|deprecated`), e os 8 campos de segurança do cabeçalho v2
  (`risk_level`, `requires_admin`, `writes`, `deletes`, `registry`, `services`, `tasks`,
  `network`, `restart`) + `undo` quando houver.
- **Category** — 16 categorias BATLAB (`automation`, `system`, `storage-advanced`,
  `windows-update`, `emergency`, …); slug = nome da pasta. Lista oficial:
  `tools/build-readmes.ps1` / README raiz.
- **Platform** — fixa: `windows`, `linux`, `macos`, `android`.
- **Tag** — livre, para filtro (ex.: `smart`, `dism`, `rede`); criar com moderação.
- **Release** — versão de uma ferramenta: `version` (semver), `download_url`,
  `sha256`, `file_size`, `released_at`.
- **Problem** — os 17 problemas (`problems/*.json`: id/order/title/desc/keywords/tools);
  posição = `order`. `problem_tools` preserva a ordem do array `tools`.
- **DownloadDaily** — agregado diário; nunca linha por evento.

## Descrição e textos

- `@desc` em PT-BR, ≤100 chars, sem ponto final (é o resumo nos cards).
- `long_description` só se o texto do `README.md` da categoria não bastar.
- Campos de segurança no admin: **dropdown com os enums exatos** (não checkbox livre) —
  ver `database.md`; o form reflete o cabeçalho, não inventa valores.

## Ciclo de vida

1. Ferramenta nova → CSV do catálogo ganha nota `impl-f1`/etc. → arquivo + cabeçalho →
   build → seed → (release) — `workflows/add-tool.md`
2. Ferramenta muda → bump de versão → rebuild → seed → release novo — `update-tool`
3. Ferramenta some do catálogo → `status = deprecated` (nunca DELETE) + saída do
   `projects.json`
