"use client";
import { useEffect, useState } from "react";
import Link from "next/link";

type Tool = { slug: string; name: string; category: string; risk: string };

export default function ToolsPage() {
  const [tools, setTools] = useState<Tool[]>([]);
  const [q, setQ] = useState("");

  useEffect(() => {
    fetch(`/api/tools`).then(r=>r.json()).then(d=>setTools(d.tools ?? []));
  }, []);

  const filtered = tools.filter(t => t.name.toLowerCase().includes(q.toLowerCase()));

  return (
    <div className="mx-auto max-w-6xl px-6 py-16">
      <div className="flex items-center justify-between mb-8">
        <h1 className="text-3xl font-semibold">Ferramentas</h1>
        <Link href="/" className="rounded-lg border border-zinc-700 px-4 py-2 text-sm">Voltar</Link>
      </div>
      <input value={q} onChange={e=>setQ(e.target.value)} placeholder="Buscar..." className="mb-6 w-full rounded-lg border border-zinc-700 bg-transparent px-4 py-3 text-zinc-200" />
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {filtered.map(t => (
          <Link key={t.slug} href={`/tools/${t.slug}`} className="rounded-2xl border border-zinc-800 bg-zinc-900/40 p-5 hover:bg-zinc-900/60 transition">
            <div className="flex items-center justify-between">
              <h3 className="font-medium">{t.name}</h3>
              <span className="text-xs rounded-full px-2 py-1 border border-zinc-700">{t.risk}</span>
            </div>
            <p className="mt-2 text-sm text-zinc-400">{t.category}</p>
          </Link>
        ))}
      </div>
    </div>
  );
}
