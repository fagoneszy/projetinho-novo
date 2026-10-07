import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { getSession } from "@/lib/session";

const RATE_LIMIT = 60;
const WINDOW_MS = 60_000;
const buckets = new Map<string, { count: number; reset: number }>();

function getIp(req: NextRequest) {
  const forwarded = req.headers.get("x-forwarded-for");
  return forwarded?.split(",")[0]?.trim() ?? "unknown";
}

export async function middleware(req: NextRequest) {
  const ip = getIp(req);
  const now = Date.now();
  const bucket = buckets.get(ip);
  if (!bucket || now > bucket.reset) {
    buckets.set(ip, { count: 1, reset: now + WINDOW_MS });
  } else if (bucket.count >= RATE_LIMIT) {
    return new NextResponse("Too Many Requests", { status: 429 });
  } else {
    bucket.count += 1;
  }

  const res = NextResponse.next();
  res.headers.set("Strict-Transport-Security", "max-age=31536000; includeSubdomains; preload");
  res.headers.set("Referrer-Policy", "strict-origin-when-cross-origin");
  res.headers.set("Permissions-Policy", "geolocation=(), microphone=(), camera=()");
  res.headers.set("Content-Security-Policy", "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; connect-src 'self'; frame-ancestors 'none';");

  const protectedPrefixes = [
    "/tools",
    "/account",
    "/admin",
    "/api/tools",
    "/api/favorites",
    "/api/admin",
    "/api/auth/signout",
  ];
  const requiresAuthentication = protectedPrefixes.some(
    (prefix) => req.nextUrl.pathname === prefix || req.nextUrl.pathname.startsWith(`${prefix}/`),
  );

  if (requiresAuthentication) {
    const session = await getSession();
    if (!session) {
      if (req.nextUrl.pathname.startsWith("/api/")) {
        return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
      }
      const loginUrl = new URL("/login", req.url);
      loginUrl.searchParams.set("callbackUrl", `${req.nextUrl.pathname}${req.nextUrl.search}`);
      return NextResponse.redirect(loginUrl);
    }
  }

  return res;
}

export const config = {
  matcher: [
    "/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp|ico|mp4|webm|woff2?|ttf|otf|css|js)$).*)",
  ],
};
