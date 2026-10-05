"use client";
import { useEffect, useState } from "react";

type Tool = {
  slug: string;
  name: string;
  category: string;
  risk: string;
  problems?: string[];
};

export default function ToolsCatalog() {
  const [tools, setTools] = useState<Tool[]>([]);
  const [risk, setRisk] = useState<string>("");
  const [category, setCategory] = useState<string>("");

  useEffect(() => {
    const params = new URLSearchParams();
    if (risk) params.set("risk", risk);
    if (category) params.set("category", category);
    fetch(`/api/tools?${params.toString()}`)
      .then(r => r.json())
      .then(d => setTools(d.tools ?? []))
      .catch(() => setTools([]));
  }, [risk, category]);

  return (
    <section className="mx-auto max-w-6xl px-6 py-20">
      <div className="flex flex-wrap gap-3 mb-8">
        {["", "low", "medium", "high"].map(r => (
          <button key={r} onClick={() => setRisk(r)} className={`rounded-full border px-4 py-2 ${risk===r?"bg-zinc-100 text-zinc-900":"border-zinc-700 text-zinc-300"}`}>{r||"todos"}</button>
        ))}
        <select value={category} onChange={e=>setCategory(e.target.value)} className="ml-auto rounded-lg border border-zinc-700 bg-transparent px-3 py-2 text-zinc-200">
          <option value="">Todas categorias</option>
          <option value="security-audit">security-audit</option>
          <option value="system-info">system-info</option>
          <option value="performance">performance</option>
        </select>
      </div>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {tools.map(t => (
          <div key={t.slug} className="rounded-2xl border border-zinc-800 bg-zinc-900/40 p-5">
            <div className="flex items-center justify-between">
              <h3 className="font-medium text-zinc-100">{t.name}</h3>
              <span className={`text-xs rounded-full px-2 py-1 border ${t.risk==="low"?"border-emerald-700 text-emerald-400":"border-amber-700 text-amber-400"}`}>{t.risk}</span>
            </div>
            <p className="mt-2 text-sm text-zinc-400">{t.category}</p>
            <a href={`/tools/${t.slug}`} className="mt-4 inline-block text-sm text-zinc-300 hover:underline">Detalhes</a>
          </div>
        ))}
      </div>
    </section>
  );
}
