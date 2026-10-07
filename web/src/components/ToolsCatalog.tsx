"use client";
import Link from "next/link";
import { useEffect, useState } from "react";

type Tool = {
  slug: string;
  name: string;
  category: string;
  severity: string;
  description: string;
};

export default function ToolsCatalog() {
  const [tools, setTools] = useState<Tool[]>([]);

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const searchParam = params.get("search") || "";
    const severityParam = params.get("severity") || "all";
    const categoryParam = params.get("category") || "all";

    const query = new URLSearchParams();
    if (severityParam && severityParam !== "all") query.set("severity", severityParam);
    if (categoryParam && categoryParam !== "all") query.set("category", categoryParam);
    if (searchParam) query.set("search", searchParam);
    fetch(`/api/tools?${query.toString()}`)
      .then((r) => r.json())
      .then((d) => setTools(d.tools ?? []))
      .catch(() => setTools([]));
  }, []);

  return (
    <section className="mx-auto max-w-6xl px-6 py-16">
      <h1 className="text-3xl font-semibold mb-12 text-center">Ferramentas</h1>

      {/* Tools grid */}
      <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        {tools.map((tool) => (
          <Link
            key={tool.slug}
            href={`/tools/${tool.slug}`}
            className="group relative overflow-hidden transition-all duration-300 hover:-translate-y-0.5"
          >
            <div className="rounded-xl border border-zinc-800/50 bg-zinc-900/50 p-6 backdrop-blur-sm hover:border-zinc-700/70 hover:bg-zinc-800/60 transition-all duration-300">
              <div className="flex items-center justify-between mb-3">
                <h3 className="font-semibold text-zinc-100">{tool.name}</h3>
                <span className={`flex items-center gap-1.5 text-xs font-medium px-2 py-0.5 rounded-full ${
                  tool.severity === "low"
                    ? "bg-emerald-500/20 text-emerald-400 border border-emerald-500/30"
                    : tool.severity === "medium"
                    ? "bg-amber-500/20 text-amber-400 border border-amber-500/30"
                    : "bg-rose-500/20 text-rose-400 border border-rose-500/30"
                }`}>
                  {tool.severity.charAt(0).toUpperCase() + tool.severity.slice(1)}
                </span>
              </div>
              <p className="text-zinc-400 text-sm mb-4 line-clamp-2">{tool.category}</p>
              <p className="text-zinc-300 text-base line-clamp-3">{tool.description}</p>
              <div className="mt-4 pt-3 border-t border-zinc-800/20">
                <span className="batlab-button inline-flex rounded-full border border-white/10 px-3 py-1.5 text-sm font-medium text-zinc-200 hover:border-white/20 hover:bg-white/5 hover:text-white">
                  Ver detalhes →
                </span>
              </div>
            </div>
          </Link>
        ))}

        {/* Empty state */}
        {tools.length === 0 && (
          <div className="col-span-full flex flex-col items-center justify-center py-12 text-center">
            <svg className="w-12 h-12 mb-4 text-zinc-500" viewBox="0 0 24 24" fill="none" stroke="currentColor">
              <circle cx="12" cy="12" r="10" strokeWidth="2"></circle>
              <line x1="8" y1="12" x2="16" y2="12" strokeWidth="2"></line>
              <line x1="12" y1="8" x2="12" y2="16" strokeWidth="2"></line>
            </svg>
            <p className="text-zinc-400">Nenhuma ferramenta encontrada com os filtros selecionados</p>
          </div>
        )}
      </div>
    </section>
  );
}
