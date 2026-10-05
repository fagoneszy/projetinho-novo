"use client";
import { useEffect, useState } from "react";
import { useParams } from "next/navigation";

type Tool = { name?: string; category?: string; risk?: string; admin?: string; slug?: string; release?: { download_url?: string; sha256?: string } };

export default function ToolDetail() {
  const { slug } = useParams<{ slug: string }>();
  const [tool, setTool] = useState<Tool | null>(null);

  useEffect(() => {
    if (!slug) return;
    fetch(`/api/tools/${slug}`).then(r=>r.json()).then(setTool).catch(()=>setTool(null));
  }, [slug]);

  if (!tool) return <div className="p-10 text-zinc-400">Carregando...</div>;

  return (
    <div className="mx-auto max-w-4xl px-6 py-20">
      <h1 className="text-4xl font-semibold">{tool.name}</h1>
      <p className="mt-2 text-zinc-400">{tool.category} • {tool.risk}</p>
      <div className="mt-8 rounded-2xl border border-zinc-800 bg-zinc-900/40 p-6">
        <h2 className="text-xl font-medium mb-4">Metadados</h2>
        <dl className="grid sm:grid-cols-2 gap-4 text-sm">
          <div><dt className="text-zinc-500">Slug</dt><dd className="text-zinc-200">{tool.slug}</dd></div>
          <div><dt className="text-zinc-500">Categoria</dt><dd className="text-zinc-200">{tool.category}</dd></div>
          <div><dt className="text-zinc-500">Risco</dt><dd className="text-zinc-200">{tool.risk}</dd></div>
          <div><dt className="text-zinc-500">Admin</dt><dd className="text-zinc-200">{tool.admin === "yes" ? "Sim" : "Não"}</dd></div>
        </dl>
        {tool.release && (
          <div className="mt-6">
            <a href={tool.release.download_url} className="inline-flex items-center rounded-xl bg-zinc-100 text-zinc-900 px-6 py-3 font-medium">Download</a>
            <p className="mt-2 text-xs text-zinc-500">SHA256: {tool.release.sha256}</p>
          </div>
        )}
      </div>
    </div>
  );
}
