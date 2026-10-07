# BATLAB Web

Aplicação Next.js (App Router) publicada na Vercel.

## Desenvolvimento

```powershell
npm ci
npm run dev
```

Para autenticação e recursos administrativos, configure no ambiente local ou
na Vercel `DATABASE_URL`, `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET` e
`NEXT_PUBLIC_SITE_URL`. Não versione valores de credenciais.

## Catálogo e dados

`site/projects.json` e `site/problems.json`, na raiz do repositório, são as
fontes versionadas do catálogo. Como a raiz de build da Vercel é `web/`, os
geradores sincronizam cópias em `src/data/`:

- `tools/build-manifest.ps1` gera `site/projects.json` e
  `web/src/data/projects.json`;
- `tools/build-problems.ps1` gera `site/problems.json` e
  `web/src/data/problems.json`.

Use esses geradores para atualizar os dados; não edite as cópias de `src/data/`
diretamente. Ferramentas com estado `published` no banco são adicionadas ao
manifesto em runtime. Se a leitura do banco falhar, a aplicação registra o
erro e usa o catálogo versionado, sinalizando a condição degradada.

## Acesso

- `/tools`, detalhes e `/api/tools/*` exigem sessão.
- `/api/tools/*/download` só entrega scripts após validar a sessão. Fontes do
  manifesto são obtidas do host permitido `raw.githubusercontent.com`.
- `/problems` e `/api/problems` exibem metadados públicos, sem código de
  ferramentas.
- O redirecionamento para login preserva o caminho interno e os filtros; o
  destino é validado para impedir redirecionamentos externos.
- `robots.txt` e `sitemap.xml` são gerados pelo Next.js. Rotas privadas não
  entram no sitemap.

## Verificação

```powershell
npm run lint
npm run build
```
