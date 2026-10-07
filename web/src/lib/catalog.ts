import projects from "@/data/projects.json";
import problemRecords from "@/data/problems.json";
import { normalizeSearchText } from "@/lib/search-text";

const categoryLabels: Record<string, string> = {
  automation: "Automação",
  customization: "Personalização",
  developer: "Desenvolvimento",
  diagnostics: "Diagnóstico",
  emergency: "Emergência",
  everyday: "Dia a dia",
  files: "Arquivos",
  games: "Jogos",
  media: "Mídia",
  network: "Rede",
  "network-advanced": "Rede avançada",
  privacy: "Privacidade",
  productivity: "Produtividade",
  "security-audit": "Segurança e auditoria",
  "storage-advanced": "Armazenamento avançado",
  system: "Sistema",
  "system-diagnosis": "Diagnóstico do sistema",
  "windows-update": "Windows Update",
};

export type CatalogTool = (typeof projects)[number];
export type CatalogProblem = (typeof problemRecords)[number];

export type ToolFilters = {
  platform?: string;
  severity?: string;
  category?: string;
  search?: string;
};

export function matchesToolFilters(
  tool: Pick<CatalogTool, "platform" | "risk" | "category" | "name" | "file" | "description">,
  filters: ToolFilters,
) {
  const query = normalizeSearchText(filters.search ?? "").slice(0, 100);
  const platform = normalizeSearchText(filters.platform ?? "");
  const severity = normalizeSearchText(filters.severity ?? "");
  const category = normalizeSearchText(filters.category ?? "");

  if (platform && normalizeSearchText(tool.platform) !== platform) return false;
  if (severity && normalizeSearchText(tool.risk) !== severity) return false;
  if (category && normalizeSearchText(tool.category) !== category) return false;
  if (!query) return true;

  const searchableText = normalizeSearchText([
    tool.name,
    tool.file,
    tool.description,
    tool.category,
    getCategoryLabel(tool.category),
    tool.platform,
    tool.risk,
  ].join(" "));

  return searchableText.includes(query);
}

export function getCategoryLabel(slug: string) {
  return categoryLabels[slug] ?? slug.replace(/-/g, " ").replace(/\b\w/g, (letter) => letter.toUpperCase());
}

export function getCatalogCategories() {
  return [...new Set(projects.map((tool) => tool.category))]
    .sort((a, b) => getCategoryLabel(a).localeCompare(getCategoryLabel(b), "pt-BR"))
    .map((slug) => ({ slug, label: getCategoryLabel(slug) }));
}

export function getCatalogTools(filters: ToolFilters = {}) {
  return projects.filter((tool) => matchesToolFilters(tool, filters));
}

export function getCatalogTool(slug: string) {
  const normalizedSlug = slug.toLowerCase();
  return projects.find((tool) => tool.slug === normalizedSlug);
}

export function getCatalogProblems() {
  return [...problemRecords].sort((a, b) => a.order - b.order);
}

export function getCatalogProblem(id: string) {
  return problemRecords.find((problem) => problem.id === id);
}

export function getProblemTools(problem: CatalogProblem) {
  const toolsBySlug = new Map(projects.map((tool) => [tool.slug, tool]));
  return problem.tools
    .map((slug) => toolsBySlug.get(slug))
    .filter((tool): tool is CatalogTool => tool !== undefined);
}
