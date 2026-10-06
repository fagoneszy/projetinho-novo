import { cookies } from "next/headers";
import { db } from "./db";
import { users } from "@/drizzle/schema";
import { eq } from "drizzle-orm";

export async function getSession() {
  const cookieStore = await cookies();
  const sessionCookie = cookieStore.get("batlab_session");
  if (!sessionCookie?.value) return null;

  let payload: { userId?: number; email?: string; name?: string };
  try {
    payload = JSON.parse(sessionCookie.value);
  } catch {
    return null;
  }

  const userId = payload.userId;
  if (!userId || !db) return null;

  const [user] = await db.select().from(users).where(eq(users.id, userId)).limit(1);
  if (!user) return null;

  return { user };
}
