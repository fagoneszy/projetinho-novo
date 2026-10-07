import { NextResponse } from "next/server";
import { getSession } from "@/lib/session";
import { getPublishedTool, toApiTool } from "@/lib/published-tools";

export async function GET(_req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const session = await getSession();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { slug } = await params;
  const result = await getPublishedTool(slug);
  if (!result.tool) {
    return NextResponse.json(
      { error: result.degraded ? "Catálogo temporariamente indisponível" : "Ferramenta não encontrada" },
      { status: result.degraded ? 503 : 404 },
    );
  }
  return NextResponse.json(toApiTool(result.tool));
}
