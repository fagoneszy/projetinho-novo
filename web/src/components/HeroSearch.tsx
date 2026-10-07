"use client";

import { AnimatePresence, motion } from "framer-motion";
import { useState } from "react";
import type { FormEvent } from "react";
import { useRouter } from "next/navigation";

const categories = [
  ["automation", "Automação"],
  ["developer", "Desenvolvimento"],
  ["diagnostics", "Diagnóstico"],
  ["security-audit", "Segurança"],
  ["network", "Rede"],
  ["privacy", "Privacidade"],
  ["productivity", "Produtividade"],
  ["files", "Arquivos"],
  ["media", "Mídia"],
  ["system", "Sistema"],
  ["emergency", "Emergência"],
  ["everyday", "Dia a dia"],
  ["customization", "Personalização"],
  ["games", "Jogos"],
  ["network-advanced", "Rede avançada"],
  ["storage-advanced", "Armazenamento avançado"],
  ["windows-update", "Windows Update"],
  ["rede", "Rede (categoria BATLAB)"],
  ["seguranca", "Segurança (categoria BATLAB)"],
  ["utilitarios", "Utilitários"],
  ["desenvolvimento", "Desenvolvimento (categoria BATLAB)"],
  ["automacao", "Automação (categoria BATLAB)"],
  ["arquivos", "Arquivos (categoria BATLAB)"],
  ["midia", "Mídia (categoria BATLAB)"],
  ["sistema", "Sistema (categoria BATLAB)"],
] as const;

const popularSearches = ["Segurança", "Automação", "APIs"];

export default function HeroSearch() {
  const [query, setQuery] = useState("");
  const [severity, setSeverity] = useState("");
  const [category, setCategory] = useState("");
  const [expanded, setExpanded] = useState(false);
  const router = useRouter();

  const searchTools = (searchQuery = query) => {
    const params = new URLSearchParams();
    const trimmedQuery = searchQuery.trim();

    if (trimmedQuery) params.set("search", trimmedQuery);
    if (severity) params.set("severity", severity);
    if (category) params.set("category", category);

    const search = params.toString();
    router.push(search ? `/tools?${search}` : "/tools");
  };

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    searchTools();
  };

  const clearFilters = () => {
    setQuery("");
    setSeverity("");
    setCategory("");
  };

  const hasFilters = Boolean(query || severity || category);

  return (
    <form
      onSubmit={handleSubmit}
      role="search"
      className={`overflow-hidden border border-white/15 bg-[#09090b]/90 shadow-[0_24px_90px_rgba(0,0,0,0.65),0_0_45px_rgba(34,211,238,0.08)] backdrop-blur-2xl transition-[border-radius,box-shadow] duration-300 ${
        expanded ? "rounded-[2rem]" : "rounded-full"
      }`}
    >
      <div className="flex items-center gap-1.5 p-1.5 sm:gap-2 sm:p-2">
        <div className="flex min-w-0 flex-1 items-center gap-3 pl-3 sm:pl-5">
          <label htmlFor="hero-search" className="sr-only">
            Buscar ferramentas
          </label>
          <svg
            aria-hidden="true"
            className="h-5 w-5 shrink-0 text-zinc-400"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
          >
            <circle cx="11" cy="11" r="7" strokeWidth="1.8" />
            <path d="m16 16 4 4" strokeWidth="1.8" strokeLinecap="round" />
          </svg>
          <input
            id="hero-search"
            type="search"
            value={query}
            onFocus={() => setExpanded(true)}
            onChange={(event) => setQuery(event.target.value)}
            placeholder="Busque ferramentas, categorias..."
            className="min-w-0 flex-1 bg-transparent py-3.5 text-sm text-white outline-none placeholder:text-zinc-500 sm:text-base"
          />
        </div>
        <button
          type="button"
          aria-expanded={expanded}
          aria-controls="hero-search-options"
          aria-label={expanded ? "Ocultar opções de busca" : "Mostrar opções de busca"}
          onClick={() => setExpanded((value) => !value)}
          className="batlab-button inline-flex h-11 shrink-0 items-center justify-center gap-2 rounded-full border border-white/10 bg-white/[0.06] px-3 text-sm font-medium text-zinc-200 hover:border-white/20 hover:bg-white/10 sm:px-4"
        >
          <svg
            aria-hidden="true"
            className="h-4 w-4"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
          >
            <path d="M4 7h9M17 7h3M4 17h3m4 0h9" strokeWidth="1.7" strokeLinecap="round" />
            <circle cx="15" cy="7" r="2" strokeWidth="1.7" />
            <circle cx="9" cy="17" r="2" strokeWidth="1.7" />
          </svg>
          <span className="hidden sm:inline">Filtros</span>
          {hasFilters && (
            <span className="h-1.5 w-1.5 rounded-full bg-cyan-300 shadow-[0_0_8px_rgba(103,232,249,0.8)]" />
          )}
        </button>
        <button
          type="submit"
          className="batlab-button inline-flex h-11 shrink-0 items-center justify-center gap-2 rounded-full bg-white px-4 text-sm font-semibold text-black shadow-[0_3px_18px_rgba(255,255,255,0.12)] hover:bg-cyan-50 sm:px-6"
        >
          Buscar
          <svg
            aria-hidden="true"
            className="hidden h-4 w-4 sm:block"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
          >
            <path d="M5 12h14m-6-6 6 6-6 6" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" />
          </svg>
        </button>
      </div>

      <AnimatePresence initial={false}>
        {expanded && (
          <motion.div
            id="hero-search-options"
            initial={{ height: 0, opacity: 0, y: -6 }}
            animate={{ height: "auto", opacity: 1, y: 0 }}
            exit={{ height: 0, opacity: 0, y: -6 }}
            transition={{ duration: 0.24, ease: "easeOut" }}
            className="overflow-hidden"
          >
            <div className="border-t border-white/[0.08] px-4 pb-4 pt-4 sm:px-6 sm:pb-5">
              <div className="grid gap-3 sm:grid-cols-[1fr_1fr_auto] sm:items-end">
                <label className="block min-w-0">
                  <span className="mb-1.5 block text-[11px] font-medium uppercase tracking-[0.12em] text-zinc-500">
                    Nível de risco
                  </span>
                  <select
                    value={severity}
                    onChange={(event) => setSeverity(event.target.value)}
                    className="w-full rounded-full border border-white/10 bg-white/[0.04] px-4 py-2.5 text-sm text-zinc-200 outline-none transition focus:border-cyan-200/40 focus:ring-2 focus:ring-cyan-200/10"
                  >
                    <option value="" className="bg-zinc-900">Qualquer risco</option>
                    <option value="low" className="bg-zinc-900">Risco baixo</option>
                    <option value="medium" className="bg-zinc-900">Risco médio</option>
                    <option value="high" className="bg-zinc-900">Risco alto</option>
                  </select>
                </label>
                <label className="block min-w-0">
                  <span className="mb-1.5 block text-[11px] font-medium uppercase tracking-[0.12em] text-zinc-500">
                    Categoria
                  </span>
                  <select
                    value={category}
                    onChange={(event) => setCategory(event.target.value)}
                    className="w-full rounded-full border border-white/10 bg-white/[0.04] px-4 py-2.5 text-sm text-zinc-200 outline-none transition focus:border-cyan-200/40 focus:ring-2 focus:ring-cyan-200/10"
                  >
                    <option value="" className="bg-zinc-900">Todas as categorias</option>
                    {categories.map(([value, label]) => (
                      <option key={value} value={value} className="bg-zinc-900">
                        {label}
                      </option>
                    ))}
                  </select>
                </label>
                {hasFilters && (
                  <button
                    type="button"
                    onClick={clearFilters}
                    className="batlab-button h-[42px] rounded-full border border-white/10 px-4 text-sm text-zinc-400 hover:border-white/20 hover:bg-white/[0.05] hover:text-white"
                  >
                    Limpar
                  </button>
                )}
              </div>

              <div className="mt-4 flex flex-wrap items-center gap-2">
                <span className="mr-1 text-xs text-zinc-500">Buscas populares</span>
                {popularSearches.map((term) => (
                  <button
                    key={term}
                    type="button"
                    onClick={() => searchTools(term)}
                    className="batlab-button rounded-full border border-white/[0.08] bg-white/[0.03] px-3.5 py-1.5 text-xs font-medium text-zinc-300 hover:border-cyan-200/25 hover:bg-cyan-200/[0.06] hover:text-cyan-100"
                  >
                    {term}
                  </button>
                ))}
              </div>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </form>
  );
}
