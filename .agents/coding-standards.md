# Padrões de código

## Linguagem e stack

- TypeScript **strict**; sem `any` (usar `unknown` + narrowing); sem `@ts-ignore`.
- Next.js **App Router**; `server component` por padrão, `client component` só quando
  precisa de interação/estado.
- Arquivos: `kebab-case.ts(x)`; componentes `PascalCase`; pastas por feature
  (`web/src/app/`, `web/src/components/`, `web/src/lib/`).
- Zod no limite do sistema (input) + tipos Drizzle derivados (`InferSelectModel`).

## Estilo

- Sem comentários de código, salvo para explicar *porquê* não óbvio.
- Strings de UI em **PT-BR**; identificadores (variáveis, rotas, colunas) em inglês.
- Funções curtas; extração quando passar de ~40 linhas; zero duplicação de lógica de
  risco/slug — importar de `web/src/lib/` (ex.: `slug.ts`, `risk.ts`).
- Sem bibliotecas novas sem registrar no `package.json` e justificar (ver security.md).

## Next.js

- `async` server components direto; `fetch` com `next: { revalidate }` onde fizer sentido
  (catálogo muda pouco).
- Route handlers: validação Zod → lógica → resposta tipada `{ ok, error? }`.
- Server actions para formulários; revalidatePath/Tag após mutação.
- Nada de efeito colateral em render; hooks só em client components.

## Git e commits

- Convencional do repo (PT-BR):
  - Ferramentas: `BATLAB fase 1 lote N: <categoria> (<n> ferramentas)`
  - App: `BATLAB app: <o quê>`
- Rodar antes de commitar (em `web/`): `npm run lint` e `npm run typecheck` (depois
  `npm run build` em mudança relevante). Ferramentas: `tools/build-manifest.ps1` exit 0.
- Nunca commitar `.env*`, `node_modules/`, `.vercel/`.

## Testes

- Sem framework de teste definido ainda — ao adicionar um, usar `vitest` (coerente com
  o stack Vite/TS) e cobrir: `lib/` puro (slug, risk, allowlist de URLs) e Zod schemas.
