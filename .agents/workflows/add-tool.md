# Workflow: adicionar ferramenta

Ordem obrigatória. Ninguém pula etapa (nem o agente).

1. **Catálogo** — a ferramenta precisa existir em `docs/catalog-v2.csv` com `status=keep`
   (ou ser uma entrada nova negociada com o mantenedor). Anotar a nota de implementação
   (`impl-f1`, etc.) na edição do campo `note`, preservando UTF-8 sem BOM.
2. **Arquivo** — criar na pasta da categoria/plataforma
   (`windows/batch/<categoria>/`, `linux/shell/<categoria>/`, …) com o cabeçalho v2 nos
   **primeiros 30 lines**: `@desc @category @platform @admin @risk @undo` (quando
   aplicável) + os 7 campos de segurança. Media+ exige os 7; `critical` exige
   `@confirm typed`. `@category` = pasta, `@platform` = raiz. Convencões:
   PascalCase + CRLF + UTF-8 sem BOM (Windows) / kebab-case + LF (shell).
3. **Validar** — parse dos blocos `powershell`/`python` embutidos; nenhum padrão
   destrutivo em ferramenta de análise; admin gate presente em ação privilegiada.
4. **Build** — `tools/build-manifest.ps1` exit 0 sem "PROBLEMAS NO CABECALHO";
   `tools/build-readmes.ps1`; `tools/build-problems.ps1` (adicionar o slug na(s)
   taxonomia(s) de problema correspondente em `problems/*.json`).
5. **Seed** — em `web/`: `npm run seed` (upsert por slug) quando o banco estiver no ar.
6. **Release** — só quando a ferramenta for publicada para download:
   `workflows/release-tool.md` (preenche `releases` com `download_url`+`sha256`).
7. **Commit** — convencional: `BATLAB fase 1 lote N: <categoria> (<n> ferramentas)`.
   **Proibido** para subagentes: commit/reset/checkout — o mantenedor commita.

Caminho futuro (admin no ar): etapa 1-2 passam a ser o formulário `+ New Script` do
`/admin`, que escreve no banco; o pipeline de build/validação continua valendo como
guarda-corpo antes de virar release.
