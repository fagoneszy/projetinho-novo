import { NextResponse } from "next/server";
import { getSession } from "@/lib/session";
import { getPublishedTools, toApiTool } from "@/lib/published-tools";

export async function GET(req: Request) {
  const session = await getSession();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const url = new URL(req.url);
  const platform = url.searchParams.get("platform");
  const severity = url.searchParams.get("severity");
  const category = url.searchParams.get("category");
  const search = url.searchParams.get("search")?.trim();

  if (
    (platform && platform.length > 50) ||
    (category && category.length > 100) ||
    (search && search.length > 100) ||
    (severity && !["low", "medium", "high", "critical"].includes(severity.toLowerCase())) ||
    (platform && !["windows", "linux", "macos", "android"].includes(platform.toLowerCase()))
  ) {
    return NextResponse.json({ error: "Invalid filter parameters" }, { status: 400 });
  }

  const result = await getPublishedTools({
    platform: platform ?? undefined,
    severity: severity ?? undefined,
    category: category ?? undefined,
    search,
  });
  return NextResponse.json({
    tools: result.tools.map(toApiTool),
    degraded: result.degraded,
  });
}
