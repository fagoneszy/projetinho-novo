import { NextResponse } from "next/server";
import { getCatalogProblems } from "@/lib/catalog";

export async function GET() {
  const data = getCatalogProblems().map((problem) => ({
    id: problem.id,
    name: problem.title,
    slug: problem.id,
    description: problem.desc,
    order: problem.order,
    keywords: problem.keywords,
    tools: problem.tools,
  }));
  return NextResponse.json({ problems: data });
}
