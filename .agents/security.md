# Segurança da aplicação

Checklist obrigatório para qualquer feature de servidor, admin ou download. Se uma regra
conflitar com velocidade, a regra vence.

## Segredos

- Segredos (`DATABASE_URL`, `GITHUB_TOKEN`, `ADMIN_KEY`, `BETTER_AUTH_SECRET`) só em
  **env de servidor** (Vercel Environment Variables / `.env.local` no `.gitignore`).
- Proibido prefixo `NEXT_PUBLIC_` em qualquer segredo; revisar diffs por esse padrão.
- Nunca logar valores de env nem `console.log` de objetos que os contenham.
- Client components recebem **dados serializados prontos**, nunca `process.env` de
  servidor.

## `/admin`

- Nenhum conteúdo de `/admin` é renderizado sem passar pelo gate de autenticação
  (middleware + verificação no servidor, não só no client).
- Fase inicial: `ADMIN_KEY` comparada com `crypto.timingSafeEqual` em cookie/header.
  Fase seguinte: Better Auth com sessão httpOnly.
- Toda mutação (server action / route handler POST) revalida a sessão **no servidor** —
  esconder botão no client não é controle de acesso.
- Rate limit/brute-force no login (throttle por IP/cookie); após falhas, resposta
  genérica (não dizer qual campo falhou).

## Entrada e saída

- **Todo** input passa por Zod no servidor (server action, route handler). Erro → 400 com
  mensagem amigável, sem vazar stack/schema.
- Nada de `dangerouslySetInnerHTML` com conteúdo do banco; texto do catálogo é renderizado
  como texto (React escapa por padrão). Markdown futuro → biblioteca com sanitização.
- URLs de download: **allowlist** — só `https://github.com/<owner>/<repo>/releases/download/…`
  (e o padrão raw do próprio repositório durante o seed). Nunca proxyar/redirecionar URL
  arbitrária vinda do banco sem validar o host.
- Ids em URL: UUID/serial opaco; nunca confiar em valor enviado pelo client (ex.:
  slug para mutação → buscar por id no servidor).
- Uploads: não existem no escopo atual; se existirem, validar tipo/tamanho no servidor.

## Integridade e dados

- `sha256` exibido junto ao download (o usuário confere a integridade do `.bat`).
- Migrations são a única forma de alterar schema; revisar o SQL gerado antes do deploy.
- Seed nunca apaga em massa; depreciação é `status`, não `DELETE` (FKs em `releases`).
- Downloads: incrementar `downloads_daily` de forma atômica (`upsert … onConflict`).

## Infra e dependências

- `npm audit` antes de fechar fase; evitar dependências obscuras (pesar custo/benefício).
- Headers de segurança: manter os defaults do Vercel/Next; se adicionar middleware de
  headers, não quebrar CSP do site.
- Segurança dos **scripts** (o produto): risco/admin/vários campos vêm do cabeçalho v2 e
  nunca são inventados no admin sem passar pelas regras de `docs/RISCOS.md` —
  ferramenta `critical` exige confirmação digitada e `high` exige dupla confirmação.
