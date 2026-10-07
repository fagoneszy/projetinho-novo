"use client";

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

export default function HeroSearch() {
  const [query, setQuery] = useState("");
  const [severity, setSeverity] = useState("");
  const [category, setCategory] = useState("");
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

  return (
    <form
      onSubmit={handleSubmit}
      role="search"
      className="overflow-hidden rounded-2xl border border-white/15 bg-[#090909]/85 shadow-[0_20px_70px_rgba(0,0,0,0.5)] backdrop-blur-xl"
    >
      <div className="flex flex-col gap-2 p-2 sm:flex-row sm:flex-wrap sm:items-center">
        <div className="flex min-w-[min(100%,220px)] flex-1 items-center gap-2 rounded-xl border border-white/10 bg-white/5 px-3 focus-within:border-white/30 focus-within:ring-2 focus-within:ring-white/10">
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
            onChange={(event) => setQuery(event.target.value)}
            placeholder="Nome, categoria ou funcionalidade..."
            className="min-w-0 flex-1 bg-transparent py-3 text-sm text-white outline-none placeholder:text-zinc-400"
          />
        </div>
        <label className="min-w-0 flex-1 sm:w-[120px] sm:flex-none">
          <span className="sr-only">Nível de risco</span>
          <select
            value={severity}
            onChange={(event) => setSeverity(event.target.value)}
            className="w-full rounded-xl border border-white/10 bg-[#171717] px-3 py-3 text-sm text-zinc-200 outline-none transition focus:border-white/30 focus:ring-2 focus:ring-white/10"
          >
            <option value="">Qualquer risco</option>
            <option value="low">Risco baixo</option>
            <option value="medium">Risco médio</option>
            <option value="high">Risco alto</option>
          </select>
        </label>
        <label className="min-w-0 flex-1 sm:w-[145px] sm:flex-none">
          <span className="sr-only">Categoria</span>
          <select
            value={category}
            onChange={(event) => setCategory(event.target.value)}
            className="w-full rounded-xl border border-white/10 bg-[#171717] px-3 py-3 text-sm text-zinc-200 outline-none transition focus:border-white/30 focus:ring-2 focus:ring-white/10"
          >
            <option value="">Todas categorias</option>
            {categories.map(([value, label]) => (
              <option key={value} value={value}>
                {label}
              </option>
            ))}
          </select>
        </label>
        <button
          type="submit"
          className="shrink-0 rounded-xl bg-white px-5 py-3 text-sm font-semibold text-black transition hover:bg-zinc-200 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-offset-2 focus-visible:ring-offset-zinc-950"
        >
          Buscar
        </button>
        {(query || severity || category) && (
          <button
            type="button"
            onClick={clearFilters}
            className="shrink-0 px-2 py-2 text-xs text-zinc-300 transition hover:text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-white/50"
          >
            Limpar
          </button>
        )}
      </div>
      <div className="flex flex-wrap items-center gap-2 border-t border-white/10 px-3 py-2.5 sm:px-4">
        <span className="mr-1 text-xs text-zinc-400">Populares:</span>
        {["Segurança", "Automação", "APIs"].map((term) => (
          <button
            key={term}
            type="button"
            onClick={() => searchTools(term)}
            className="rounded-full border border-white/10 bg-white/5 px-3 py-1 text-xs text-zinc-200 transition hover:border-white/25 hover:bg-white/10 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-white/50"
          >
            {term}
          </button>
        ))}
      </div>
    </form>
  );
}
