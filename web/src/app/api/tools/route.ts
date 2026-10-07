import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { tools } from "@/drizzle/schema";
import { and, eq, ilike, or } from "drizzle-orm";

export async function GET(req: Request) {
  const url = new URL(req.url);
  const platform = url.searchParams.get("platform");
  const severity = url.searchParams.get("severity");
  const category = url.searchParams.get("category");
  const search = url.searchParams.get("search")?.trim();

  const conditions = [];
  
  if (platform) conditions.push(eq(tools.platform, platform));
  if (severity) conditions.push(ilike(tools.severity, severity));
  if (category) conditions.push(ilike(tools.category, category));
  if (search) {
    const searchPattern = `%${search}%`;
    const searchCondition = or(
      ilike(tools.name, searchPattern),
      ilike(tools.description, searchPattern),
      ilike(tools.category, searchPattern),
    );
    if (searchCondition) conditions.push(searchCondition);
  }

  const where = conditions.length ? and(...conditions) : undefined;
  const data = await db.select().from(tools).where(where);

  return NextResponse.json({ tools: data });
}
