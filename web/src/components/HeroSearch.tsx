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

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const params = new URLSearchParams();
    const trimmedQuery = query.trim();

    if (trimmedQuery) params.set("search", trimmedQuery);
    if (severity) params.set("severity", severity);
    if (category) params.set("category", category);

    const search = params.toString();
    router.push(search ? `/tools?${search}` : "/tools");
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
      className="overflow-hidden rounded-3xl border border-white/15 bg-[#090909]/75 shadow-[0_24px_100px_rgba(0,0,0,0.55)] backdrop-blur-xl"
    >
      <div className="flex items-center gap-2 p-2 sm:gap-3 sm:p-3">
        <label htmlFor="hero-search" className="sr-only">
          Buscar ferramentas
        </label>
        <svg
          aria-hidden="true"
          className="ml-3 h-5 w-5 shrink-0 text-zinc-400"
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
          placeholder="O que você precisa encontrar?"
          className="min-w-0 flex-1 bg-transparent px-2 py-3 text-base text-white outline-none placeholder:text-zinc-400 sm:text-lg"
        />
        <button
          type="submit"
          className="shrink-0 rounded-2xl bg-white px-5 py-3 text-sm font-semibold text-black transition hover:bg-zinc-200 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-offset-2 focus-visible:ring-offset-zinc-950 sm:px-7"
        >
          Buscar
        </button>
      </div>

      <div className="flex flex-col gap-2 border-t border-white/10 px-3 py-3 sm:flex-row sm:items-center sm:px-5">
        <span className="shrink-0 text-xs font-medium text-zinc-400">
          Filtrar por
        </span>
        <div className="flex flex-1 flex-col gap-2 min-[420px]:flex-row">
          <label className="min-w-0 flex-1">
            <span className="sr-only">Nível de risco</span>
            <select
              value={severity}
              onChange={(event) => setSeverity(event.target.value)}
              className="w-full rounded-xl border border-white/10 bg-white/5 px-3 py-2 text-sm text-zinc-200 outline-none transition focus:border-white/30 focus:ring-2 focus:ring-white/10"
            >
              <option value="" className="bg-zinc-900">
                Qualquer risco
              </option>
              <option value="low" className="bg-zinc-900">
                Risco baixo
              </option>
              <option value="medium" className="bg-zinc-900">
                Risco médio
              </option>
              <option value="high" className="bg-zinc-900">
                Risco alto
              </option>
            </select>
          </label>
          <label className="min-w-0 flex-1">
            <span className="sr-only">Categoria</span>
            <select
              value={category}
              onChange={(event) => setCategory(event.target.value)}
              className="w-full rounded-xl border border-white/10 bg-white/5 px-3 py-2 text-sm text-zinc-200 outline-none transition focus:border-white/30 focus:ring-2 focus:ring-white/10"
            >
              <option value="" className="bg-zinc-900">
                Todas as categorias
              </option>
              {categories.map(([value, label]) => (
                <option key={value} value={value} className="bg-zinc-900">
                  {label}
                </option>
              ))}
            </select>
          </label>
        </div>
        {(query || severity || category) && (
          <button
            type="button"
            onClick={clearFilters}
            className="shrink-0 px-2 py-2 text-xs text-zinc-400 transition hover:text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-white/50"
          >
            Limpar
          </button>
        )}
      </div>
    </form>
  );
}
