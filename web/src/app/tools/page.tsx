import NavBar from "@/components/NavBar";
import Link from "next/link";
import { redirect } from "next/navigation";
import { getSession } from "@/lib/session";
import { getCategoryLabel, matchesToolFilters } from "@/lib/catalog";
import { getPublishedTools } from "@/lib/published-tools";

type ToolSearchParams = {
  platform?: string | string[];
  severity?: string | string[];
  category?: string | string[];
  search?: string | string[];
};

export default async function ToolsHome({ searchParams }: { searchParams: Promise<ToolSearchParams> }) {
  const rawFilters = await searchParams;
  const filters = {
    platform: typeof rawFilters.platform === "string" ? rawFilters.platform.slice(0, 50) : undefined,
    severity: typeof rawFilters.severity === "string" ? rawFilters.severity.toLowerCase() : undefined,
    category: typeof rawFilters.category === "string" ? rawFilters.category.slice(0, 100) : undefined,
    search: typeof rawFilters.search === "string" ? rawFilters.search.slice(0, 100) : undefined,
  };
  const session = await getSession();
  if (!session) {
    const query = new URLSearchParams();
    for (const [key, value] of Object.entries(filters)) {
      if (value) query.set(key, value);
    }
    const returnTo = `/tools${query.size ? `?${query.toString()}` : ""}`;
    redirect(`/login?callbackUrl=${encodeURIComponent(returnTo)}`);
  }

  const { tools: allTools, degraded } = await getPublishedTools();
  const matchingTools = allTools.filter((tool) => matchesToolFilters(tool, filters));
  const categories = [...new Set(allTools.map((tool) => tool.category))]
    .sort((a, b) => getCategoryLabel(a).localeCompare(getCategoryLabel(b), "pt-BR"))
    .map((slug) => ({ slug, label: getCategoryLabel(slug) }));
  const total = allTools.length;
  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-6xl px-6 py-12">
        <h1 className="mb-2 text-3xl font-semibold">Ferramentas</h1>
        <p className="mb-6 text-sm text-zinc-400">
          {matchingTools.length} de {total} ferramentas do catálogo.
        </p>
        {degraded && (
          <p role="status" className="mb-6 rounded-xl border border-amber-500/30 bg-amber-500/10 px-4 py-3 text-sm text-amber-100">
            O catálogo principal está disponível. Ferramentas publicadas recentemente podem demorar a aparecer.
          </p>
        )}
        <form method="get" className="mb-8 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
          <label className="sr-only" htmlFor="tool-search">Buscar ferramentas</label>
          <input
            id="tool-search"
            name="search"
            defaultValue={filters.search ?? ""}
            maxLength={100}
            placeholder="Nome, categoria ou função..."
            className="min-w-0 rounded-full border border-zinc-800 bg-zinc-900 px-4 py-2.5 text-sm outline-none focus:border-zinc-600"
          />
          <select name="severity" defaultValue={filters.severity ?? ""} aria-label="Nível de risco" className="rounded-full border border-zinc-800 bg-zinc-900 px-4 py-2.5 text-sm">
            <option value="">Qualquer risco</option>
            <option value="low">Risco baixo</option>
            <option value="medium">Risco médio</option>
            <option value="high">Risco alto</option>
            <option value="critical">Risco crítico</option>
          </select>
          <select name="category" defaultValue={filters.category ?? ""} aria-label="Categoria" className="rounded-full border border-zinc-800 bg-zinc-900 px-4 py-2.5 text-sm">
            <option value="">Todas as categorias</option>
            {categories.map((category) => (
              <option key={category.slug} value={category.slug}>{category.label}</option>
            ))}
          </select>
          <div className="flex gap-2">
            <select name="platform" defaultValue={filters.platform ?? ""} aria-label="Plataforma" className="min-w-0 flex-1 rounded-full border border-zinc-800 bg-zinc-900 px-4 py-2.5 text-sm">
              <option value="">Todas as plataformas</option>
              <option value="windows">Windows</option>
              <option value="linux">Linux</option>
              <option value="macos">macOS</option>
              <option value="android">Android</option>
            </select>
            <button className="batlab-button rounded-full bg-zinc-100 px-5 py-2.5 text-sm font-medium text-zinc-900">Filtrar</button>
          </div>
        </form>
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {matchingTools.map((t) => (
            <Link key={t.slug} href={`/tools/${t.slug}`} className="border border-zinc-800 rounded-xl p-4 hover:bg-zinc-900">
              <div className="font-medium">{t.name}</div>
              <div className="text-sm text-zinc-400">{getCategoryLabel(t.category)} • {t.risk} • {t.platform}</div>
              <div className="text-xs text-zinc-500 mt-2">{t.description}</div>
            </Link>
          ))}
        </div>
        {matchingTools.length === 0 && (
          <div className="mt-8 rounded-2xl border border-zinc-800 bg-zinc-900/40 px-6 py-12 text-center">
            <h2 className="text-lg font-medium">Nenhuma ferramenta encontrada</h2>
            <p className="mt-2 text-sm text-zinc-400">Tente outro termo ou remova alguns filtros.</p>
            <Link href="/tools" className="batlab-button mt-5 inline-flex rounded-full border border-zinc-700 px-4 py-2 text-sm hover:bg-zinc-800">
              Limpar filtros
            </Link>
          </div>
        )}
      </div>
    </main>
  );
}
