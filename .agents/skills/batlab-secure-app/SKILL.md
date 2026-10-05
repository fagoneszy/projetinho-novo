---
name: batlab-secure-app
description: Use when building or touching server-side code of the BATLAB web app (web/): route handlers, server actions, middleware, environment variables/secrets, the /admin area, authentication (ADMIN_KEY gate or Better Auth), forms with Zod validation, download endpoints/URLs, rate limiting, security headers, or any code that reads DATABASE_URL, GITHUB_TOKEN or admin credentials. Also use when reviewing a diff for security regressions.
---

# BATLAB App Seguro

Fonte de verdade: `.agents/security.md`. Este skill é o checklist executável; leia o
arquivo antes de features de servidor novas.

## Gate de decisão (antes de escrever código)

1. O código roda no **client**? → nada de segredo, nada de autorização só no client,
   nada de query direta ao banco.
2. Recebe **input**? → schema Zod, parse no servidor, resposta 400 genérica.
3. Muta **estado**? → revalida sessão/admin no servidor, depois revalidatePath/Tag.
4. Retorna **URL**? → allowlist `https://github.com/<owner>/<repo>/releases/download/…`
   (mais raw do próprio repo em dev); rejeitar todo host fora do padrão.

## Padrões aprovados

**Gate do /admin (fase 1)** — middleware + verificação server com comparação constant-time:

```ts
import { timingSafeEqual } from "crypto";
export function checkAdminKey(sent: string | null): boolean {
  const expected = process.env.ADMIN_KEY ?? "";
  if (!sent || !expected) return false;
  const a = Buffer.from(sent), b = Buffer.from(expected);
  return a.length === b.length && timingSafeEqual(a, b);
}
```

- Nunca comparar com `===` de string; nunca logar a chave; erro de auth genérico.

**Zod em toda route handler:**

```ts
const Body = z.object({ slug: z.string().regex(/^[a-z0-9]+$/) });
const parsed = Body.safeParse(await req.json());
if (!parsed.success) return Response.json({ ok: false, error: "requisição inválida" }, { status: 400 });
```

**Env**: segredos só server-side (`DATABASE_URL`, `ADMIN_KEY`, `BETTER_AUTH_SECRET`,
`GITHUB_TOKEN`). Diff review: caçar `NEXT_PUBLIC_` + nome de segredo = bloquear.

## Proibido

- `dangerouslySetInnerHTML` com conteúdo do banco/usuário.
- `eval`, `child_process` com input do usuário, hospedar/executar `.bat` no servidor.
- Mutações POST sem revalidação de admin no servidor.
- Interpolar input em SQL (drizzle parameterized sempre).
- Comentar/ocultar erro de auth com `try/catch` silencioso — logar o motivo sem valores
  sensíveis.

## Antes de fechar

- [ ] `npm run lint` + `npm run typecheck` (+ `npm run build` se mudou rota)
- [ ] Diff revisado por: segredo no client? URL fora da allowlist? mutação sem gate?
- [ ] Formulários: erro de validação visível em PT-BR sem vazar schema interno
