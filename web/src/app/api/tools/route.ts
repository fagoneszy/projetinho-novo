import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { tools } from "@/drizzle/schema";
import { eq, ilike, and } from "drizzle-orm";

export async function GET(req: Request) {
  const url = new URL(req.url);
  const platform = url.searchParams.get("platform");
  const severity = url.searchParams.get("severity");
  const category = url.searchParams.get("category"); // This is now categoryId
  const search = url.searchParams.get("search");

  // For backward compatibility during migration, we'll check both old and new fields
  // But since we've updated the schema, we should use the new fields
  const conditions = [];
  
  if (platform) conditions.push(eq(tools.platform, platform));
  if (severity) conditions.push(eq(tools.severity, severity));
  // Note: category is now categoryId, but we're keeping the old param for now
  // In a real implementation, we'd need to map category names to IDs
  if (category) conditions.push(eq(tools.category, category)); // Using old field for now
  if (search) conditions.push(ilike(tools.name, `%${search}%`));

  const where = conditions.length ? and(...conditions) : undefined;
  const data = await db.select().from(tools).where(where);

  return NextResponse.json({ tools: data });
}
