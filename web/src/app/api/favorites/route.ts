import { NextResponse } from "next/server";
import { getSession } from "@/lib/session";
import { db } from "@/lib/db";
import { favorites } from "@/drizzle/schema";
import { eq, and } from "drizzle-orm";

export async function POST(req: Request) {
  const session = await getSession();
  if (!session) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const { slug } = await req.json();
  if (!slug) return NextResponse.json({ error: "Missing slug" }, { status: 400 });
  await db.insert(favorites).values({ userId: session.user.id, toolSlug: slug });
  return NextResponse.json({ ok: true });
}

export async function DELETE(req: Request) {
  const session = await getSession();
  if (!session) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const { slug } = await req.json();
  await db.delete(favorites).where(and(eq(favorites.userId, session.user.id), eq(favorites.toolSlug, slug)));
  return NextResponse.json({ ok: true });
}
