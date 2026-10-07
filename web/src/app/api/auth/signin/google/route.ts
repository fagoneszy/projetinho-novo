import { NextResponse } from "next/server";
import { safeReturnTo } from "@/lib/safe-return-to";

export async function GET(req: Request) {
  const site = process.env.NEXT_PUBLIC_SITE_URL ?? new URL(req.url).origin;
  const redirectUri = `${site}/api/auth/callback/google`;
  const returnTo = safeReturnTo(new URL(req.url).searchParams.get("returnTo"));
  const params = new URLSearchParams({
    client_id: process.env.GOOGLE_CLIENT_ID ?? "",
    redirect_uri: redirectUri,
    response_type: "code",
    scope: "openid email profile",
    access_type: "offline",
    prompt: "consent",
  });
  const authUrl = `https://accounts.google.com/o/oauth2/v2/auth?${params.toString()}`;
  const response = NextResponse.redirect(authUrl);
  response.cookies.set("batlab_return_to", returnTo, {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/api/auth/callback/google",
    maxAge: 10 * 60,
  });
  return response;
}
