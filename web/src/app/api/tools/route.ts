import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { tools } from "@/drizzle/schema";
import { eq, ilike, and } from "drizzle-orm";

export async function GET(req: Request) {
  const url = new URL(req.url);
  const platform = url.searchParams.get("platform");
  const severity = url.searchParams.get("severity");
  const category = url.searchParams.get("category");
  const search = url.searchParams.get("search");

  const conditions = [];
  if (platform) conditions.push(eq(tools.platform, platform));
  if (severity) conditions.push(eq(tools.severity, severity));
  if (category) conditions.push(eq(tools.category, category));
  if (search) conditions.push(ilike(tools.name, `%${search}%`));

  const where = conditions.length ? and(...conditions) : undefined;
  const data = await db.select().from(tools).where(where);

  return NextResponse.json({ tools: data });
}
