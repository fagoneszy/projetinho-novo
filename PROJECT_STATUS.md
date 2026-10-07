# BATLAB — Status do projeto

Atualizado em 7 de outubro de 2026.

## Fonte de verdade do catálogo

- `windows/`, `linux/`, `macos/` e `android/` guardam os scripts distribuídos.
- `site/projects.json` é o manifesto gerado por `tools/build-manifest.ps1`.
- `problems/*.json` é a origem de `site/problems.json`, gerado por
  `tools/build-problems.ps1`.
- Os geradores também sincronizam os manifests para `web/src/data/`, dentro
  da raiz Next.js que a Vercel compila. Não editar as cópias em `web/src/data/`
  manualmente.
- A configuração de links do manifesto está em `site/config.js`.

## Inventário atual

- 439 ferramentas no manifesto: 434 Windows e 5 para Linux, macOS e Android.
- Risco: 310 `low`, 120 `medium`, 9 `high` e 0 `critical`.
- 17 problemas catalogados; todos os slugs relacionados existem no manifesto.
- 434 arquivos `.bat` encontrados, não vazios; os geradores validam os
  metadados obrigatórios antes de aceitar o manifesto.
- Categorias Windows: automation 30, customization 25, developer 30,
  diagnostics 20, emergency 1, everyday 20, files 30, games 30, media 25,
  network 30, network-advanced 30, privacy 1, productivity 30,
  security-audit 29, storage-advanced 23, system 30, system-diagnosis 25 e
  windows-update 25.

## Aplicação web

- `site/` contém a versão estática legada.
- `web/` é a aplicação Next.js publicada na Vercel.
- A home disponibiliza busca e filtros alimentados pelas categorias do
  manifesto; `/tools` e suas APIs exigem sessão; `/problems` e sua API são
  públicos e usam os dados versionados.
- Ferramentas publicadas no banco são combinadas com o manifesto. Se a leitura
  do banco falhar, o catálogo do manifesto continua disponível, a aplicação
  registra o erro e informa a condição degradada ao usuário.
- Downloads do manifesto são obtidos apenas de `raw.githubusercontent.com`;
  ferramentas publicadas no banco são entregues pelo endpoint autenticado.
- `robots.txt` e `sitemap.xml` são rotas geradas pelo Next.js; conteúdo privado
  de ferramentas/admin não é listado no sitemap.

## Estado de implementação

- A expansão e validação de scripts continua por categoria, preservando os
  cabeçalhos v2 de risco e segurança.
- O catálogo web deve refletir o manifesto gerado e qualquer ferramenta
  publicada no banco, sem depender de uma segunda lista de categorias
  codificada na interface.
- A meta histórica de 957 ferramentas é uma meta de roadmap, não a contagem
  atual. Não publicar números de itens restantes até reconciliar a meta com
  `docs/catalog-v2.csv` e deduplicar o inventário.
- O CMS interno segue como fluxo administrativo separado: novas ferramentas
  são publicadas no banco, enquanto o catálogo versionado permanece
  distribuível e disponível como base de continuidade.
- `docs/CHECKLIST-CORRECOES-WEB-2026-10-07.md` registra os reparos e os testes
  executados nesta rodada. A publicação dessas mudanças e a conferência final
  na Vercel ainda dependem de sincronização/deploy.
