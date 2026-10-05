import { readFile } from "node:fs/promises";
import { join } from "node:path";

type Tool = { slug?: string };

export async function GET(req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  try {
    const projectsPath = join(process.cwd(), "..", "site", "projects.json");
    const data = await readFile(projectsPath, "utf-8");
    const tools: unknown[] = JSON.parse(data);
    const tool = (tools as Tool[]).find((t) => t.slug === slug);
    if (!tool) return Response.json({ error: "não encontrado" }, { status: 404 });
    return Response.json(tool);
  } catch {
    return Response.json({ error: "erro interno" }, { status: 500 });
  }
}
