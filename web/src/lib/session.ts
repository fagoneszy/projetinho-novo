import { cookies } from "next/headers";
import { db } from "./db";
import { sessions, users } from "@/drizzle/schema";
import { eq } from "drizzle-orm";
import { hash } from "bcryptjs";

export async function getSession() {
  const cookieStore = await cookies();
  const sessionCookie = cookieStore.get("batlab_session");
  if (!sessionCookie?.value) return null;

  const sessionToken = sessionCookie.value;
  if (!sessionToken) return null;

  // Hash the token to use as lookup key
  const tokenHash = await hash(sessionToken, 10);

  // Find session by token hash
  const [session] = await db
    .select()
    .from(sessions)
    .where(eq(sessions.tokenHash, tokenHash))
    .limit(1);

  if (!session) return null;

  // Check if session is expired
  if (new Date(session.expiresAt) < new Date()) {
    // Delete expired session
    await db.delete(sessions).where(eq(sessions.id, session.id));
    return null;
  }

  // Update last seen
  await db
    .update(sessions)
    .set({ lastSeenAt: new Date() })
    .where(eq(sessions.id, session.id));

  // Get user data
  const [user] = await db
    .select()
    .from(users)
    .where(eq(users.id, session.userId))
    .limit(1);

  if (!user) return null;

  return { user };
}

// Helper function to create a session
export async function createSession(userId: number) {
  // Generate a random session token
  const token = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
  
  // Hash the token for storage
  const tokenHash = await hash(token, 10);

  const [session] = await db
    .insert(sessions)
    .values({
      tokenHash,
      userId,
      expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
    })
    .returning();

  return { token, sessionId: session.id };
}

// Function to delete a session by token hash
export async function deleteSessionByToken(token: string) {
  const tokenHash = await hash(token, 10);
  await db.delete(sessions).where(eq(sessions.tokenHash, tokenHash));
}

// Function to delete a session by sessionId (if needed)
export async function deleteSession(sessionId: number) {
  await db.delete(sessions).where(eq(sessions.id, sessionId));
}
