"use client";

import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { useEffect, useMemo, useRef, useState } from "react";
import type { FormEvent } from "react";
import { useRouter } from "next/navigation";
import { normalizeSearchText } from "@/lib/search-text";

type CategoryOption = { slug: string; label: string };

const popularCategories = ["security-audit", "automation", "network"];

export default function HeroSearch({ categories }: { categories: CategoryOption[] }) {
  const [query, setQuery] = useState("");
  const [severity, setSeverity] = useState("");
  const [category, setCategory] = useState("");
  const [expanded, setExpanded] = useState(false);
  const [categoryOpen, setCategoryOpen] = useState(false);
  const [categorySearch, setCategorySearch] = useState("");
  const [activeCategoryIndex, setActiveCategoryIndex] = useState(0);
  const router = useRouter();
  const reduceMotion = useReducedMotion();
  const categorySearchRef = useRef<HTMLInputElement>(null);
  const categoryTriggerRef = useRef<HTMLButtonElement>(null);
  const filteredCategories = useMemo(() => {
    const normalizedSearch = normalizeSearchText(categorySearch);
    return categories.filter(({ slug, label }) =>
      normalizeSearchText(`${label} ${slug}`).includes(normalizedSearch),
    );
  }, [categories, categorySearch]);

  const searchTools = (searchQuery = query, searchCategory = category) => {
    const params = new URLSearchParams();
    const trimmedQuery = searchQuery.trim();

    if (trimmedQuery) params.set("search", trimmedQuery);
    if (severity) params.set("severity", severity);
    if (searchCategory) params.set("category", searchCategory);

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

  useEffect(() => {
    if (categoryOpen) {
      categorySearchRef.current?.focus();
    }
  }, [categoryOpen]);

  const hasFilters = Boolean(query || severity || category);

  return (
    <form
      onSubmit={handleSubmit}
      role="search"
      className={`relative border border-white/15 bg-[#09090b]/90 shadow-[0_24px_90px_rgba(0,0,0,0.65),0_0_45px_rgba(34,211,238,0.08)] backdrop-blur-2xl transition-[border-radius,box-shadow] duration-300 motion-reduce:transition-none ${
        expanded ? "rounded-t-[2rem] rounded-b-none border-b-0" : "rounded-full"
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
            maxLength={100}
            value={query}
            onFocus={() => setExpanded(true)}
            onChange={(event) => setQuery(event.target.value)}
            placeholder="Nome, categoria ou função..."
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

      <div
        id="hero-search-options"
        aria-hidden={!expanded}
        inert={!expanded}
        className={`absolute left-0 right-0 top-[calc(100%-1px)] z-20 overflow-hidden rounded-b-[2rem] border-x border-b bg-[#09090b]/95 shadow-[0_24px_90px_rgba(0,0,0,0.65)] backdrop-blur-2xl transition-[max-height,opacity,border-color] ease-out motion-reduce:transition-none ${
          expanded
            ? "border-white/15 opacity-100 duration-300"
            : "border-transparent opacity-0 duration-200"
        }`}
        style={{ maxHeight: expanded ? "640px" : "0px" }}
      >
        <div>
          <div className="border-t border-white/[0.08] px-4 pb-4 pt-4 sm:px-6 sm:pb-5">
              <div className="grid gap-4 sm:grid-cols-2 sm:items-start">
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

                <div className="relative min-w-0">
                  <span className="mb-1.5 block text-[11px] font-medium uppercase tracking-[0.12em] text-zinc-500">
                    Categoria
                  </span>
                  <button
                    ref={categoryTriggerRef}
                    type="button"
                    aria-haspopup="listbox"
                    aria-expanded={categoryOpen}
                    aria-controls="hero-category-options"
                    aria-label="Escolher categoria"
                    onClick={() => {
                      setCategoryOpen((open) => !open);
                      setCategorySearch("");
                      setActiveCategoryIndex(0);
                    }}
                    onKeyDown={(event) => {
                      if (event.key === "ArrowDown" || event.key === "Enter" || event.key === " ") {
                        event.preventDefault();
                        setCategoryOpen(true);
                        setCategorySearch("");
                        setActiveCategoryIndex(0);
                      }
                    }}
                    className="flex w-full items-center justify-between gap-3 rounded-full border border-white/10 bg-white/[0.04] px-4 py-2.5 text-left text-sm text-zinc-200 outline-none transition hover:border-white/20 focus:border-cyan-200/40 focus:ring-2 focus:ring-cyan-200/10"
                  >
                    <span className={category ? "truncate" : "truncate text-zinc-400"}>
                      {categories.find((option) => option.slug === category)?.label ?? "Todas as categorias"}
                    </span>
                    <svg
                      aria-hidden="true"
                      className={`h-4 w-4 shrink-0 text-zinc-500 transition-transform ${categoryOpen ? "rotate-180" : ""}`}
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path d="m6 9 6 6 6-6" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" />
                    </svg>
                  </button>
                  <AnimatePresence initial={false}>
                    {categoryOpen && (
                      <motion.div
                        initial={{ height: 0, opacity: 0 }}
                        animate={{ height: "auto", opacity: 1 }}
                        exit={{ height: 0, opacity: 0 }}
                        transition={{ duration: reduceMotion ? 0 : 0.18, ease: "easeOut" }}
                        className="overflow-hidden"
                      >
                        <div className="mt-2 rounded-2xl border border-white/10 bg-[#101012] p-2">
                          <label htmlFor="hero-category-search" className="sr-only">
                            Filtrar categorias
                          </label>
                          <input
                            ref={categorySearchRef}
                            id="hero-category-search"
                            type="search"
                            role="combobox"
                            aria-autocomplete="list"
                            aria-expanded="true"
                            aria-controls="hero-category-options"
                            aria-activedescendant={
                              filteredCategories[activeCategoryIndex]
                                ? `hero-category-${filteredCategories[activeCategoryIndex].slug}`
                                : undefined
                            }
                            value={categorySearch}
                            onChange={(event) => {
                              setCategorySearch(event.target.value);
                              setActiveCategoryIndex(0);
                            }}
                            onKeyDown={(event) => {
                              if (event.key === "ArrowDown") {
                                event.preventDefault();
                                setActiveCategoryIndex((index) =>
                                  filteredCategories.length
                                    ? Math.min(index + 1, filteredCategories.length - 1)
                                    : 0,
                                );
                              } else if (event.key === "ArrowUp") {
                                event.preventDefault();
                                setActiveCategoryIndex((index) => Math.max(index - 1, 0));
                              } else if (event.key === "Enter" && filteredCategories[activeCategoryIndex]) {
                                event.preventDefault();
                                setCategory(filteredCategories[activeCategoryIndex].slug);
                                setCategoryOpen(false);
                                setCategorySearch("");
                                categoryTriggerRef.current?.focus();
                              } else if (event.key === "Escape") {
                                event.preventDefault();
                                setCategoryOpen(false);
                                setCategorySearch("");
                                categoryTriggerRef.current?.focus();
                              }
                            }}
                            placeholder="Digite para filtrar..."
                            className="mb-2 w-full rounded-xl border border-white/[0.08] bg-black/40 px-3 py-2 text-sm text-white outline-none placeholder:text-zinc-600 focus:border-cyan-200/30"
                          />
                          <div
                            id="hero-category-options"
                            role="listbox"
                            aria-label="Categorias disponíveis"
                            className="max-h-40 overflow-y-auto overscroll-contain"
                          >
                            <button
                              type="button"
                              id="hero-category-all"
                              role="option"
                              aria-selected={!category}
                              onClick={() => {
                                setCategory("");
                                setCategoryOpen(false);
                                setCategorySearch("");
                                categoryTriggerRef.current?.focus();
                              }}
                              className={`w-full rounded-xl px-3 py-2 text-left text-sm transition ${
                                !category ? "bg-cyan-200/10 text-cyan-100" : "text-zinc-300 hover:bg-white/[0.06]"
                              }`}
                            >
                              Todas as categorias
                            </button>
                            {filteredCategories.map(({ slug, label }, index) => (
                              <button
                                key={slug}
                                type="button"
                                id={`hero-category-${slug}`}
                                role="option"
                                aria-selected={category === slug}
                                onMouseEnter={() => setActiveCategoryIndex(index)}
                                onClick={() => {
                                  setCategory(slug);
                                  setCategoryOpen(false);
                                  setCategorySearch("");
                                  categoryTriggerRef.current?.focus();
                                }}
                                className={`w-full rounded-xl px-3 py-2 text-left text-sm transition ${
                                  activeCategoryIndex === index
                                    ? "bg-white/[0.08] text-white"
                                    : category === slug
                                      ? "text-cyan-100"
                                      : "text-zinc-300 hover:bg-white/[0.06]"
                                }`}
                              >
                                {label}
                              </button>
                            ))}
                            {filteredCategories.length === 0 && (
                              <p className="px-3 py-3 text-sm text-zinc-500">
                                Nenhuma categoria encontrada.
                              </p>
                            )}
                          </div>
                        </div>
                      </motion.div>
                    )}
                  </AnimatePresence>
                </div>
              </div>

              <div className="mt-4 flex flex-wrap items-center gap-2">
                <span className="mr-1 text-xs text-zinc-500">Buscas populares</span>
                {popularCategories.map((slug) => {
                  const option = categories.find((item) => item.slug === slug);
                  if (!option) return null;
                  return (
                    <button
                      key={slug}
                      type="button"
                      onClick={() => searchTools(query, slug)}
                      className="batlab-button rounded-full border border-white/[0.08] bg-white/[0.03] px-3.5 py-1.5 text-xs font-medium text-zinc-300 hover:border-cyan-200/25 hover:bg-cyan-200/[0.06] hover:text-cyan-100"
                    >
                      {option.label}
                    </button>
                  );
                })}
              </div>

              <div className="mt-4 flex items-center justify-end gap-2 border-t border-white/[0.08] pt-3">
                {hasFilters && (
                  <button
                    type="button"
                    onClick={clearFilters}
                    className="batlab-button rounded-full border border-white/10 px-4 py-2 text-sm text-zinc-400 hover:border-white/20 hover:bg-white/[0.05] hover:text-white"
                  >
                    Limpar filtros
                  </button>
                )}
                <button
                  type="submit"
                  className="batlab-button rounded-full bg-white px-5 py-2 text-sm font-semibold text-black hover:bg-cyan-50"
                >
                  Aplicar busca
                </button>
              </div>
            </div>
        </div>
      </div>
    </form>
  );
}
