"use client";

import { useEffect, useState } from "react";

export default function HeroFilters() {
  const [risk, setRisk] = useState<string>("all");
  const [category, setCategory] = useState<string>("all");

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    setRisk(params.get("severity") || "all");
    setCategory(params.get("category") || "all");
  }, []);

  const updateParam = (key: string, value: string | null) => {
    const params = new URLSearchParams(window.location.search);
    if (value && value !== "all") params.set(key, value);
    else params.delete(key);
    window.location.search = params.toString();
  };

  return (
    <div className="w-full flex flex-col items-center gap-4 mb-8">
      <div className="flex flex-wrap items-center gap-6">
        <div>
          <label className="block text-xs font-medium text-zinc-500 mb-2 text-center">Severidade</label>
          <div className="flex gap-2">
            {[
              ["all", "Todos"],
              ["low", "Baixa"],
              ["medium", "Média"],
              ["high", "Alta"],
            ].map(([value, label]) => (
              <button
                key={value}
                onClick={() => updateParam("severity", value as string)}
                className={`px-3 py-1.5 rounded-full text-xs font-medium transition-all duration-200 ${
                  risk === value
                    ? "bg-zinc-800 text-zinc-100 ring-1 ring-zinc-700"
                    : "bg-zinc-900/50 text-zinc-300 hover:bg-zinc-800/70"
                }`}
              >
                {label}
              </button>
            ))}
          </div>
        </div>

        <div>
          <label className="block text-xs font-medium text-zinc-500 mb-2 text-center">Categoria</label>
          <select
            value={category}
            onChange={(e) => updateParam("category", e.target.value)}
            className="w-[200px] px-3 py-2 rounded-xl bg-zinc-900/70 border border-zinc-800 text-zinc-200 focus:outline-none focus:ring-2 focus:ring-zinc-600"
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
    </div>
  );
}
