import { z } from "zod";
import { timingSafeEqual } from "node:crypto";

function checkAdminKey(sent: string | null): boolean {
  const expected = process.env.ADMIN_KEY ?? "";
  if (!sent || !expected) return false;
  const a = Buffer.from(sent);
  const b = Buffer.from(expected);
  if (a.length !== b.length) return false;
  return timingSafeEqual(a, b);
}

export async function POST(req: Request) {
  const body = await req.json().catch(() => null);
  const schema = z.object({ token: z.string().min(1) });
  const parsed = schema.safeParse(body);
  if (!parsed.success) {
    return Response.json({ ok: false, error: "requisição inválida" }, { status: 400 });
  }
  const ok = checkAdminKey(parsed.data.token);
  if (!ok) {
    return Response.json({ ok: false, error: "não autorizado" }, { status: 401 });
  }
  return Response.json({ ok: true });
}
