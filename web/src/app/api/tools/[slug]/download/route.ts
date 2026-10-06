import { NextResponse } from "next/server";
import { getSession } from "@/lib/session";
import { db } from "@/lib/db";
import { tools } from "@/drizzle/schema";
import { eq } from "drizzle-orm";

export async function GET(req: Request, context: { params: Promise<{ slug: string }> }) {
  const session = await getSession();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { slug } = await context.params;
  const [tool] = await db.select().from(tools).where(eq(tools.slug, slug)).limit(1);
  if (!tool) {
    return NextResponse.json({ error: "Not found" }, { status: 404 });
  }

  return NextResponse.json({ downloadUrl: `/api/files/${tool.slug}.bat`, tool });
}
