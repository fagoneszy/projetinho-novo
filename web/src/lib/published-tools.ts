import { createHash } from "node:crypto";
import { and, eq } from "drizzle-orm";
import { tools, toolSecurity } from "@/drizzle/schema";
import { db } from "@/lib/db";
import {
  getCatalogTool,
  getCatalogTools,
  matchesToolFilters,
  type ToolFilters,
} from "@/lib/catalog";

type ManifestTool = ReturnType<typeof getCatalogTools>[number] & {
  sourceKind: "manifest";
  code?: string;
};

type DatabaseTool = {
  slug: string;
  name: string;
  file: string;
  description: string;
  platform: string;
  category: string;
  type: string;
  risk: string;
  admin: boolean;
  writes: string;
  deletes: string;
  registry: string;
  services: string;
  tasks: string;
  network: string;
  restart: string;
  size: string;
  sha256: string;
  version: string;
  download: string;
  source: string;
  code: string;
  sourceKind: "database";
};

export type PublishedTool = ManifestTool | DatabaseTool;

export type PublishedToolResult = {
  tools: PublishedTool[];
  total: number;
  degraded: boolean;
};

function databaseTool(row: {
  tool: typeof tools.$inferSelect;
  security: typeof toolSecurity.$inferSelect | null;
}): DatabaseTool {
  const code = row.tool.code ?? "";
  const type = row.tool.type.toLowerCase().replace(/[^a-z0-9]/g, "") || "txt";
  return {
    slug: row.tool.slug,
    name: row.tool.name,
    file: `${row.tool.slug}.${type}`,
    description: row.tool.description ?? "",
    platform: row.tool.platform.toLowerCase(),
    category: row.tool.category,
    type: row.tool.type,
    risk: row.security?.riskLevel.toLowerCase() ?? "unknown",
    admin: row.security?.requiresAdmin ?? true,
    writes: row.security?.writesFiles ? "user" : "none",
    deletes: row.security?.deletesFiles ? "files" : "none",
    registry: row.security?.modifiesRegistry ? "write" : "none",
    services: "unknown",
    tasks: "unknown",
    network: row.security?.accessesNetwork ? "write" : "none",
    restart: "unknown",
    size: `${Buffer.byteLength(code, "utf8")} bytes`,
    sha256: createHash("sha256").update(code).digest("hex"),
    version: "database",
    download: `/api/tools/${encodeURIComponent(row.tool.slug)}/download`,
    source: "",
    code,
    sourceKind: "database",
  };
}

function manifestTools(): ManifestTool[] {
  return getCatalogTools().map((tool) => ({ ...tool, sourceKind: "manifest" }));
}

async function publishedDatabaseTools() {
  return db
    .select({ tool: tools, security: toolSecurity })
    .from(tools)
    .leftJoin(toolSecurity, eq(toolSecurity.toolId, tools.id))
    .where(eq(tools.status, "published"));
}

export async function getPublishedTools(filters: ToolFilters = {}): Promise<PublishedToolResult> {
  let allTools: PublishedTool[] = manifestTools();
  let degraded = false;
  try {
    const rows = await publishedDatabaseTools();
    const merged = new Map<string, PublishedTool>(allTools.map((tool) => [tool.slug, tool]));
    for (const row of rows) {
      if (!merged.has(row.tool.slug)) merged.set(row.tool.slug, databaseTool(row));
    }
    allTools = [...merged.values()];
  } catch (error) {
    degraded = true;
    console.error("Could not read published database tools; serving the versioned manifest", error);
  }

  const filtered = allTools.filter((tool) => matchesToolFilters(tool, filters));
  return { tools: filtered, total: allTools.length, degraded };
}

export async function getPublishedTool(slug: string): Promise<{ tool?: PublishedTool; degraded: boolean }> {
  const manifestTool = getCatalogTool(slug);
  if (manifestTool) return { tool: { ...manifestTool, sourceKind: "manifest" }, degraded: false };

  try {
    const [row] = await db
      .select({ tool: tools, security: toolSecurity })
      .from(tools)
      .leftJoin(toolSecurity, eq(toolSecurity.toolId, tools.id))
      .where(and(eq(tools.slug, slug), eq(tools.status, "published")))
      .limit(1);
    return { tool: row ? databaseTool(row) : undefined, degraded: false };
  } catch (error) {
    console.error("Could not look up published database tool", { slug, error });
    return { degraded: true };
  }
}

export function toApiTool(tool: PublishedTool) {
  const metadata = { ...tool };
  delete metadata.code;
  return {
    ...metadata,
    severity: tool.risk,
  };
}
