import { NextResponse } from "next/server";

export async function GET() {
  const res = NextResponse.redirect(new URL("/", "https://batlab.vercel.app"));
  res.cookies.set("batlab_session", "", { httpOnly: true, secure: true, sameSite: "lax", path: "/", maxAge: 0 });
  return res;
}
