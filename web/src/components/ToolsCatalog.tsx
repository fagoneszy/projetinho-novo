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
  const [risk, setRisk] = useState<string>("all");
  const [category, setCategory] = useState<string>("all");
  const [search, setSearch] = useState<string>("");

  useEffect(() => {
    const params = new URLSearchParams();
    if (risk && risk !== "all") params.set("severity", risk);
    if (category && category !== "all") params.set("category", category);
    if (search) params.set("search", search);
    fetch(`/api/tools?${params.toString()}`)
      .then((r) => r.json())
      .then((d) => setTools(d.tools ?? []))
      .catch(() => setTools([]));
  }, [risk, category, search]);

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      // Trigger search on Enter
    }
  };

  return (
    <section className="mx-auto max-w-6xl px-6 py-16">
      <h1 className="text-3xl font-semibold mb-12 text-center">Ferramentas</h1>
      
      {/* Search and filters */}
      <div className="flex flex-wrap items-center gap-4 mb-12">
        {/* Search input */}
        <div className="flex-1 min-w-[200px]">
          <div className="relative">
            <input
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              onKeyDown={handleKeyDown}
              placeholder="Buscar ferramentas..."
              className="w-full px-4 py-3 rounded-xl bg-zinc-900/50 border border-zinc-800/50 text-zinc-200 placeholder-zinc-400 focus:outline-none focus:ring-2 focus:ring-zinc-600 transition-all duration-200"
            />
            <svg className="absolute inset-y-0 right-3 flex h-5 w-5 items-center justify-center text-zinc-400" viewBox="0 0 24 24" fill="none" stroke="currentColor">
              <circle cx="11" cy="11" r="8" strokeWidth="2"></circle>
              <path d="M21 21l-4.35-4.35" strokeWidth="2"></path>
            </svg>
          </div>
        </div>
        
        {/* Risk filter */}
        <div className="flex-shrink-0">
          <label className="block text-xs font-medium text-zinc-400 mb-1">Severidade</label>
          <div className="flex gap-1">
            {[["all", "Todos"], ["low", "Baixa"], ["medium", "Média"], ["high", "Alta"]].map(
              ([value, label]) => (
                <button
                  key={value}
                  onClick={() => setRisk(value)}
                  className={`px-3 py-1.5 rounded-full text-xs font-medium transition-all duration-200 ${
                    risk === value
                      ? "bg-zinc-800/50 text-zinc-100"
                      : "bg-transparent text-zinc-300 hover:bg-zinc-900/20"
                  }`}
                >
                  {label}
                </button>
              )
            )}
          </div>
        </div>
        
        {/* Category filter */}
        <div className="flex-shrink-0">
          <label className="block text-xs font-medium text-zinc-400 mb-1">Categoria</label>
          <select
            value={category}
            onChange={(e) => setCategory(e.target.value)}
            className="w-[180px] px-3 py-2 rounded-xl bg-zinc-900/50 border border-zinc-800/50 text-zinc-200 placeholder-zinc-400 focus:outline-none focus:ring-2 focus:ring-zinc-600 transition-all duration-200"
          >
            <option value="all">Todas categorias</option>
            <option value="automation">Automação</option>
            <option value="developer">Desenvolvimento</option>
            <option value="diagnostics">Diagnóstico</option>
            <option value="security-audit">Segurança</option>
            <option value="network">Rede</option>
            <option value="privacy">Privacidade</option>
            <option value="productivity">Produtividade</option>
            <option value="files">Arquivos</option>
            <option value="media">Mídia</option>
            <option value="system">Sistema</option>
            <option value="emergency">Emergência</option>
            <option value="everyday">Dia a Dia</option>
            <option value="customization">Personalização</option>
            <option value="games">Jogos</option>
            <option value="network-advanced">Rede Avançada</option>
            <option value="storage-advanced">Storage Avançado</option>
            <option value="windows-update">Windows Update</option>
          </select>
        </div>
      </div>

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
                <a href={`/tools/${tool.slug}`} className="text-sm font-medium text-zinc-200 hover:text-zinc-100 transition-colors duration-200">
                  Ver detalhes →
                </a>
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
