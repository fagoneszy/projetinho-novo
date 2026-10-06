import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { users } from "@/drizzle/schema";
import { eq } from "drizzle-orm";

export async function GET(req: Request) {
  const url = new URL(req.url);
  const code = url.searchParams.get("code");
  if (!code) return NextResponse.redirect(new URL("/login?error=missing_code", url.origin));

  const site = process.env.NEXT_PUBLIC_SITE_URL ?? url.origin;
  const redirectUri = `${site}/api/auth/callback/google`;

  const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      code,
      client_id: process.env.GOOGLE_CLIENT_ID ?? "",
      client_secret: process.env.GOOGLE_CLIENT_SECRET ?? "",
      redirect_uri: redirectUri,
      grant_type: "authorization_code",
    }),
  });
  const tokens = await tokenRes.json();
  const userRes = await fetch("https://www.googleapis.com/oauth2/v2/userinfo", {
    headers: { Authorization: `Bearer ${tokens.access_token}` },
  });
  const profile = await userRes.json();

  let userId = null;
  if (db) {
    const existing = await db.select().from(users).where(eq(users.googleSub, profile.id)).limit(1);
    if (existing.length) {
      userId = existing[0].id;
    } else {
      const inserted = await db.insert(users).values({
        googleSub: profile.id,
        email: profile.email,
        name: profile.name,
      }).returning({ id: users.id });
      userId = inserted[0]?.id ?? null;
    }
  }

  const res = NextResponse.redirect(new URL("/tools", url.origin));
  res.cookies.set("batlab_session", JSON.stringify({ userId, email: profile.email, name: profile.name }), {
    httpOnly: true,
    secure: true,
    sameSite: "lax",
    path: "/",
    maxAge: 60 * 60 * 24 * 7,
  });
  return res;
}
