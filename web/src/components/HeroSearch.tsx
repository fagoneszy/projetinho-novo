"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";

export default function HeroSearch() {
  const [query, setQuery] = useState("");
  const router = useRouter();

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    setQuery(params.get("search") || "");
  }, []);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (query.trim()) {
      router.push(`/tools?search=${encodeURIComponent(query.trim())}`);
    } else {
      router.push("/tools");
    }
  };

  return (
    <div className="w-full py-4 bg-[#030303]">
      <div className="mx-auto max-w-3xl px-4">
        <form onSubmit={handleSubmit} className="relative">
          <input
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Buscar ferramentas, problemas ou categorias..."
            className="w-full rounded-[2rem] bg-zinc-900/70 border border-zinc-800 px-6 py-4 pr-28 text-center text-zinc-100 placeholder-zinc-500 focus:outline-none focus:ring-2 focus:ring-zinc-600 backdrop-blur text-lg shadow-[inset_0_1px_0_0_rgba(255,255,255,0.02)]"
          />
          <button
            type="submit"
            className="absolute right-3 top-1/2 -translate-y-1/2 rounded-full bg-white px-5 py-2.5 text-sm font-semibold text-black hover:bg-zinc-200 transition shadow-sm"
            aria-label="Buscar"
          >
            Buscar
          </button>
        </form>
        <p className="mt-3 text-center text-xs text-zinc-500">
          Digite para encontrar soluções entre 400+ ferramentas auditadas
        </p>
      </div>
    </div>
  );
}
