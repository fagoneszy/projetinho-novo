import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const RATE_LIMIT = 60;
const WINDOW_MS = 60_000;
const buckets = new Map<string, { count: number; reset: number }>();

function getIp(req: NextRequest) {
  const forwarded = req.headers.get("x-forwarded-for");
  return forwarded?.split(",")[0]?.trim() ?? "unknown";
}

export function middleware(req: NextRequest) {
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

  const publicPaths = ["/", "/login", "/api/auth/signin/google", "/api/auth/callback/google", "/api/tools"];
  const isPublic = publicPaths.some(p => req.nextUrl.pathname === p || req.nextUrl.pathname.startsWith("/api/tools/"));
  const session = req.cookies.get("batlab_session");
  if (!isPublic && !session) {
    return NextResponse.redirect(new URL("/login", req.url));
  }
  return res;
}

export const config = { matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"] };
