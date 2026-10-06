import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { tools } from "@/drizzle/schema";

export async function GET(req: Request) {
  const key = req.headers.get("x-admin-key");
  if (key !== process.env.ADMIN_KEY) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const data = await db.select().from(tools);
  return NextResponse.json({ tools: data });
}
