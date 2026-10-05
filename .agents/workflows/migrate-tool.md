# Workflow: migrar ferramenta (categoria/plataforma/slug)

## Trocar de categoria

1. `git mv` do arquivo para a pasta nova (`windows/batch/<nova-cat>/`).
2. Atualizar `@category` no cabeçalho (= nova pasta) e `@platform` se mudou de raiz.
3. Rodar `build-manifest` + `build-readmes` (READMEs das duas categorias mudam) +
   `build-problems` (aviso se o slug ficou órfão — decidir se sai de algum problema).
4. Catálogo `docs/catalog-v2.csv`: ajustar `sec`/`pl` da linha (regex por número,
   preservar aspas/UTF-8 sem BOM).
5. Seed: `category_id` muda por upsert (slug do arquivo **não muda**).
6. Commit: `BATLAB fase 1: <slug> move para <categoria>`.

## Trocar de plataforma

Como acima, mas mexendo na raiz (`windows/`→`linux/`) e `@platform`; a ferramenta pode
precisar de **reescrita real** (um `.bat` não vira `.sh` por rename — nesse caso é
substituição de implementação, tratar como ferramenta nova + depreciação da antiga).

## Renomear arquivo/slug — quase proibido

O slug é a chave de tudo (problems, site anchors, banco, URLs de SEO).

1. Só com aprovação explícita do mantenedor.
2. Atualizar **em cascata**: `problems/*.json` (todos os arrays `tools`), READMEs,
   `projects.json`, entradas `releases` do banco (manter histórico!), sitemap.
3. Registrar redirect: no app v3, rota antiga → 308 para a nova (SEO).
4. Commit com nota `BREAKING: slug <antigo> → <novo>`.

## Depreciar

- Nunca `DELETE` no banco: `status = deprecated`, sai do `projects.json` (build não o
  inclui mais), README marca descontinuada, `releases` histórico permanece.
