# Workflow: release (distribuição)

O GitHub é o **distribuidor**: fonte + Releases. O banco guarda metadados.

## Estratégia de tag

- **Lote**: uma tag por lote publicado — `batlab-lote-<N>` — contendo todos os `.bat`/`.sh`
  alterados naquele lote (assets por arquivo: `FolderOrganizer.bat`).
- **Atualização pontual**: quando uma ferramenta muda fora de lote, release individual —
  tag `tool-<slug>-v<versão>` com aquele único asset.
- Nunca force-push de tag já publicada; erro de release = tag nova.

## URL de download

```text
https://github.com/<OWNER>/<REPO>/releases/download/<tag>/<NomeDoArquivo>.bat
```

Essa é a **allowlist** de `security.md` (junto do raw do próprio repo durante
dev/seed). `releases.download_url` no banco só recebe URL desse padrão.

## Passos

1. Builds limpos (`build-manifest` exit 0; `SHA256SUMS.txt` atualizado).
2. Criar tag + release com os assets:
   `gh release create <tag> <arquivos...> --title "<tag>" --notes "<resumo PT-BR>"`
3. Para cada ferramenta publicada, upsert em `releases`:
   `version` (do cabeçalho), `download_url`, `sha256` (de `SHA256SUMS.txt`),
   `file_size`, `released_at`, e atualizar `scripts.current_version`.
4. Conferir baixando um asset e comparando o SHA-256 local com o do banco/JSON.
5. Commit: `BATLAB release: <tag>`.

## Seed inicial (antes de houver Releases)

Até a primeira publicação, `download_url` pode apontar para o raw do arquivo no repositório
(`raw.githubusercontent.com/<OWNER>/<REPO>/main/...`) mantendo `sha256` real — a troca
para URLs de Release acontece no primeiro release em massa, sem mudar o schema.
