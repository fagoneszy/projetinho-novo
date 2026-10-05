import { readFile } from "node:fs/promises";
import { join } from "node:path";

type Tool = { risk?: string; category?: string; problem?: string[] };

export async function GET(req: Request) {
  const url = new URL(req.url);
  const risk = url.searchParams.get("risk");
  const category = url.searchParams.get("category");
  const problem = url.searchParams.get("problem");
  try {
    const projectsPath = join(process.cwd(), "..", "site", "projects.json");
    const data = await readFile(projectsPath, "utf-8");
    const tools: unknown[] = JSON.parse(data);
    let filtered = tools as Tool[];
    if (risk) filtered = filtered.filter((t) => t.risk === risk);
    if (category) filtered = filtered.filter((t) => t.category === category);
    if (problem) filtered = filtered.filter((t) => t.problem?.includes(problem));
    return Response.json({ total: filtered.length, tools: filtered.slice(0, 100) });
  } catch {
    return Response.json({ error: "seed não disponível" }, { status: 500 });
  }
}
