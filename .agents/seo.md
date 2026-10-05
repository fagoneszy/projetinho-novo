# SEO

Catálogo público indexável é canal de aquisição — toda página de ferramenta é uma
landing.

## Obrigatório

- `metadata`/`generateMetadata` por rota (title, description, canonical, openGraph,
  twitter). Padrão: `<Ferramenta> — <desc curta> | BATLAB`.
- `sitemap.xml` + `robots.ts` dinâmicos (listar `/`, `/problemas/[slug]`,
  `/categorias/[slug]`, `/ferramentas/[slug]`).
- JSON-LD `SoftwareApplication` (+ `Offer` 0) nas páginas de ferramenta; `BreadcrumbList`
  nas de categoria.
- URLs canônicas estáveis: slug é imutável (ver content-model.md) — renomear slug é
  quebra de SEO e exige redirect 308 (ver workflows/migrate-tool.md).
- Imagens/OG geradas ou estáticas com alt descritivo em PT-BR.
- Indexação: `site/` estático e `web/` **não** devem competir no mesmo host — quando o
  v3 for ao ar, definir quem é canônico (redirect do antigo para o novo, nunca dois
  conteúdos duplicados no ar).

## Conteúdo

- `description` da ferramenta = meta description (≤160 chars, já vem do `@desc`).
- Headings: um `h1` por página; problema → `h1` do problema; seções com `h2`.
- Páginas de problema e categoria têm texto introdutório real (não só lista de cards).
- Interning: cada ferramenta linka sua categoria, problema(s) e afins.

## Performance (Core Web Vitals)

- Server components por padrão; lista grande → paginação ou virtualização.
- `next/image` para assets; sem JS desnecessário na página de catálogo (filtros podem
  ser server-side com `?searchParams`).
