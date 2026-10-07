import { cookies } from "next/headers";
import { db } from "./db";
import { sessions, users } from "@/drizzle/schema";
import { eq } from "drizzle-orm";

// Server-only function to get session from cookies
export async function getSession() {
  const cookieStore = await cookies();
  const token = cookieStore.get("batlab_session")?.value;

  if (!token) {
    return null;
  }

  const [session] = await db
    .select()
    .from(sessions)
    .where(eq(sessions.tokenHash, Buffer.from(token, "hex").toString("base64")))
    .limit(1);

  if (!session) {
    return null;
  }

  if (session.expiresAt < new Date()) {
    await db.delete(sessions).where(eq(sessions.id, session.id));
    return null;
  }

  await db
    .update(sessions)
    .set({ lastSeenAt: new Date() })
    .where(eq(sessions.id, session.id));

  const [user] = await db
    .select()
    .from(users)
    .where(eq(users.id, session.userId))
    .limit(1);

  if (!user) {
    return null;
  }

  return {
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      avatarUrl: user.avatarUrl,
    },
  };
}

export async function createSession(userId: number) {
  // Generate a random token
  const token = Array.from({ length: 32 }, () => 
    Math.floor(Math.random() * 16).toString(16)
  ).join("");

  const tokenHash = Buffer.from(token, "hex").toString("base64");

  await db.insert(sessions).values({
    tokenHash,
    userId,
    expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
    createdAt: new Date(),
    lastSeenAt: new Date(),
  });

  return token;
}

export async function deleteSession(tokenHash: string) {
  await db.delete(sessions).where(eq(sessions.tokenHash, tokenHash));
}

export async function deleteSessionByToken(token: string) {
  const tokenHash = Buffer.from(token, "hex").toString("base64");
  await deleteSession(tokenHash);
}

export async function deleteSessionByUserId(userId: number) {
  await db.delete(sessions).where(eq(sessions.userId, userId));
}