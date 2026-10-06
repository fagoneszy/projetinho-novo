import NavBar from "@/components/NavBar";
import Link from "next/link";

async function getTools(params: URLSearchParams) {
  const q = new URLSearchParams(params);
  const qs = q.toString();
  const url = `${process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000"}/api/tools${qs ? `?${qs}` : ""}`;
  const res = await fetch(url, { cache: "no-store" });
  if (!res.ok) return [];
  const data = await res.json();
  return data.tools ?? [];
}

export default async function ToolsHome({ searchParams }: { searchParams?: { platform?: string; severity?: string; category?: string; search?: string } }) {
  const tools = await getTools(new URLSearchParams(searchParams as any));
  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-6xl px-6 py-12">
        <h1 className="text-3xl font-semibold mb-6">Ferramentas</h1>
        <form method="get" className="flex flex-wrap gap-3 mb-6">
          <select name="severity" className="bg-zinc-900 border border-zinc-800 rounded-lg px-3 py-2">
            <option value="">Severidade</option>
            <option value="low">Low</option>
            <option value="medium">Medium</option>
            <option value="high">High</option>
          </select>
          <select name="category" className="bg-zinc-900 border border-zinc-800 rounded-lg px-3 py-2">
            <option value="">Categoria</option>
            <option value="security-audit">Security Audit</option>
            <option value="diagnostics">Diagnostics</option>
          </select>
          <input name="search" placeholder="Buscar..." className="bg-zinc-900 border border-zinc-800 rounded-lg px-3 py-2 w-48" />
          <button className="bg-zinc-100 text-zinc-900 rounded-lg px-4 py-2">Filtrar</button>
        </form>
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {tools.map((t: any) => (
            <Link key={t.slug} href={`/tools/${t.slug}`} className="border border-zinc-800 rounded-xl p-4 hover:bg-zinc-900">
              <div className="font-medium">{t.name}</div>
              <div className="text-sm text-zinc-400">{t.category} • {t.severity}</div>
              <div className="text-xs text-zinc-500 mt-2">{t.description}</div>
            </Link>
          ))}
        </div>
      </div>
    </main>
  );
}
