import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { problems } from "@/drizzle/schema";

export async function GET() {
  const data = await db.select().from(problems);
  return NextResponse.json({ problems: data });
}
