# Checklist de correções web — 7 de outubro de 2026

## Escopo e estado

Correções implementadas, verificadas localmente e publicadas na Vercel.
O commit `9a81e8c` foi sincronizado com `main`; o check Vercel reportou
sucesso e os smoke tests públicos em produção passaram.

## Achados corrigidos

- [x] **API e catálogo vazios/500:** catálogo, detalhe e problemas passaram a
  usar os manifests como base comum. Ferramentas `published` do banco são
  adicionadas quando disponíveis; falhas do banco são registradas no servidor
  e o catálogo versionado continua disponível com aviso de degradação.
- [x] **Detalhe `/tools/DNSFlush` com erro:** removida a leitura de arquivo
  dependente do diretório de execução; o detalhe usa o manifesto empacotado.
  Slugs são normalizados para minúsculas (`DNSFlush` → `dnsflush`), sem mudar
  o nome de exibição.
- [x] **Download quebrado/incoerente:** scripts do manifesto são obtidos do
  host HTTPS permitido e servidos como anexo; ferramentas do banco usam o
  conteúdo publicado armazenado. Rotas de download exigem sessão.
- [x] **Acesso anônimo inconsistente:** middleware protege explicitamente
  `/tools`, `/account`, `/admin` e APIs privadas. APIs recusam visitantes com
  `401`; páginas protegidas encaminham ao login com o destino interno salvo.
  Problemas, recursos SEO e páginas inexistentes continuam públicos.
- [x] **Retorno do login e busca:** termos e filtros são preservados até a tela
  de login e no link Google. O destino é limitado a caminhos internos para
  evitar redirecionamento externo.
- [x] **Página `/problems` sem conteúdo:** índice e detalhes usam o manifesto
  validado, mostram descrições e ferramentas relacionadas e têm estado vazio
  explícito. A API pública retorna metadados, nunca o código dos scripts.
- [x] **Busca e categorias divergentes:** categorias e atalhos populares são
  derivados das categorias reais; foram incluídos risco crítico, plataforma,
  acentos-insensibilidade, limites de entrada e valores selecionados na tela
  de resultados.
- [x] **`robots.txt` e `sitemap.xml` ausentes:** rotas Next.js públicas
  adicionadas. O sitemap contém home, índice de problemas e seus detalhes; não
  lista ferramentas nem áreas privadas.
- [x] **Polimento observado:** título 404 traduzido para português e
  pré-carregamento da fonte mono desativado para evitar pré-carregar a fonte
  usada apenas em áreas de código.
- [x] **Documentação contraditória:** README e status reconciliados com o
  manifesto regenerado (439 ferramentas, 434 Windows, 5 multiplataforma,
  17 problemas). A política de segurança agora também descreve os limites da
  aplicação web.
- [x] **Build Vercel com raiz `web/`:** os geradores mantêm cópias dos
  manifests em `web/src/data/`, evitando referências fora da raiz de build.
  `site/config.js` aponta para `fagoneszy/projetinho-novo`.

## Evidências de validação

- [x] `tools/build-manifest.ps1`: gerou 439 ferramentas e validou os
  metadados dos scripts; distribuições de risco: 310 `low`, 120 `medium`,
  9 `high`, 0 `critical`.
- [x] `tools/build-problems.ps1`: gerou 17 problemas sem avisos de slugs
  inexistentes.
- [x] Verificação dos JSONs: cópias web idênticas aos manifests de origem,
  zero slugs duplicados e zero referências quebradas.
- [x] `npm run build` em `web/`: build de produção e TypeScript concluídos;
  `/robots.txt` e `/sitemap.xml` constam na saída.
- [x] ESLint direcionado: todos os arquivos alterados passaram.
- [x] Smoke test no servidor de produção local: índice/API de problemas
  retornaram `200`; sitemap e robots `200` (19 URLs no sitemap); API de
  ferramentas, detalhe, download, admin e favoritos sem sessão retornaram
  `401`; `/tools` e detalhe encaminharam para login preservando parâmetros.
- [x] Teste de interação no navegador: abertura da busca, filtro de
  categorias por teclado e envio resultaram no destino de login com
  `category=security-audit` preservado.
- [x] Teste de segurança do retorno OAuth: um `returnTo` externo foi
  substituído por `/tools`.
- [x] Rota inexistente serviu o 404 customizado em português.
- [x] HEAD do arquivo `DNSFlush.bat` na origem configurada respondeu `200`.
- [x] `git diff --check` sem erros de whitespace.
- [x] Deploy de `9a81e8c` na Vercel concluído com sucesso.
- [x] Smoke tests no domínio publicado: API de problemas `200` com 17 itens,
  sitemap `200` com 19 URLs, robots `200` bloqueando ferramentas/conta/admin,
  `/tools` redireciona para login preservando a busca e `/api/tools` responde
  `401` sem sessão.

## Validações restantes

- [ ] Completar o fluxo Google OAuth com uma conta de teste autenticada e
  validar listagem, detalhe e download com sessão válida. Nenhuma conta ou
  credencial foi usada nesta verificação.

## Nota de lint existente

O ESLint direcionado aos arquivos alterados passou. `npm run lint` global
continua bloqueado por um erro preexistente e não relacionado em
`web/src/lib/utils.ts:4` (`no-explicit-any`), além de avisos em arquivos não
alterados nesta rodada.
