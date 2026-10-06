import { NextResponse } from "next/server";
import { deleteSessionByToken } from "@/lib/session";
import { cookies } from "next/headers";

export async function GET() {
  const cookieStore = await cookies();
  const sessionCookie = cookieStore.get("batlab_session");
  
  if (sessionCookie?.value) {
    try {
      await deleteSessionByToken(sessionCookie.value);
    } catch (error) {
      // If deletion fails, we still want to clear the cookie
      console.error("Failed to delete session:", error);
    }
  }

  const res = NextResponse.redirect(new URL("/", "https://batlab.vercel.app"));
  res.cookies.set("batlab_session", "", { httpOnly: true, secure: true, sameSite: "lax", path: "/", maxAge: 0 });
  return res;
}
