import { NextResponse } from "next/server";
import { getSession } from "@/lib/session";
import { getPublishedTool } from "@/lib/published-tools";

export async function GET(_req: Request, context: { params: Promise<{ slug: string }> }) {
  const session = await getSession();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { slug } = await context.params;
  const result = await getPublishedTool(slug);
  const tool = result.tool;
  if (!tool) {
    return NextResponse.json(
      { error: result.degraded ? "Catálogo temporariamente indisponível" : "Ferramenta não encontrada" },
      { status: result.degraded ? 503 : 404 },
    );
  }

  const filename = tool.file.replace(/[^A-Za-z0-9._-]/g, "_");
  const headers = {
    "Content-Type": "application/octet-stream",
    "Content-Disposition": `attachment; filename="${filename}"`,
    "Cache-Control": "private, no-store",
    "X-Content-Type-Options": "nosniff",
  };
  if (tool.sourceKind === "database") {
    if (!tool.code) {
      console.error("Published database tool has no script content", { slug });
      return NextResponse.json({ error: "Arquivo de ferramenta indisponível" }, { status: 500 });
    }
    return new NextResponse(tool.code, { headers });
  }

  let downloadUrl: URL;
  try {
    downloadUrl = new URL(tool.download);
  } catch (error) {
    console.error("Invalid download URL in catalog manifest", { slug, error });
    return NextResponse.json({ error: "Link de download inválido" }, { status: 500 });
  }

  if (downloadUrl.protocol !== "https:" || downloadUrl.hostname !== "raw.githubusercontent.com") {
    console.error("Untrusted download host in catalog manifest", { slug, hostname: downloadUrl.hostname });
    return NextResponse.json({ error: "Origem de download não autorizada" }, { status: 500 });
  }

  let fileResponse: Response;
  try {
    fileResponse = await fetch(downloadUrl, { cache: "force-cache" });
  } catch (error) {
    console.error("Tool download fetch failed", { slug, error });
    return NextResponse.json({ error: "Não foi possível obter o arquivo" }, { status: 502 });
  }
  if (!fileResponse.ok || !fileResponse.body) {
    console.error("Tool download source returned an error", { slug, status: fileResponse.status });
    return NextResponse.json({ error: "Arquivo de ferramenta indisponível" }, { status: 502 });
  }

  return new NextResponse(fileResponse.body, {
    headers,
  });
}
