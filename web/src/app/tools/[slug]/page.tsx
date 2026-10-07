import { notFound } from "next/navigation";
import NavBar from "@/components/NavBar";
import { getSession } from "@/lib/session";
import { redirect } from "next/navigation";
import Link from "next/link";
import { getCategoryLabel } from "@/lib/catalog";
import { getPublishedTool } from "@/lib/published-tools";

export default async function ToolDetail({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const session = await getSession();
  if (!session) redirect(`/login?callbackUrl=${encodeURIComponent(`/tools/${slug}`)}`);

  const { tool, degraded } = await getPublishedTool(slug);
  if (!tool && !degraded) return notFound();
  if (!tool) {
    return (
      <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
        <NavBar />
        <div className="mx-auto max-w-4xl px-6 py-16">
          <h1 className="text-2xl font-semibold">Ferramenta temporariamente indisponível</h1>
          <p className="mt-3 text-zinc-400">Não foi possível consultar a publicação. Tente novamente em instantes.</p>
          <Link href="/tools" className="batlab-button mt-6 inline-flex rounded-full border border-zinc-700 px-5 py-2.5 hover:bg-zinc-800">Voltar ao catálogo</Link>
        </div>
      </main>
    );
  }

  const metadata = [
    ["Risco", tool.risk],
    ["Requer administrador", tool.admin ? "Sim" : "Não"],
    ["Escrita", tool.writes],
    ["Exclusão", tool.deletes],
    ["Registro", tool.registry],
    ["Serviços", tool.services],
    ["Tarefas", tool.tasks],
    ["Rede", tool.network],
    ["Reinicialização", tool.restart],
  ] as const;

  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-4xl px-6 py-12">
        <h1 className="text-4xl font-semibold">{tool.name}</h1>
        <p className="mt-2 text-zinc-400">{getCategoryLabel(tool.category)} • {tool.risk} • {tool.platform}</p>
        <div className="mt-8 rounded-2xl border border-zinc-800 bg-zinc-900/40 p-6">
          <h2 className="text-xl font-medium mb-4">Descrição</h2>
          <p className="text-zinc-300">{tool.description}</p>
          <h3 className="mt-6 text-lg font-medium">Informações de segurança</h3>
          <dl className="mt-3 grid gap-3 sm:grid-cols-2">
            {metadata.map(([label, value]) => (
              <div key={label} className="rounded-lg border border-zinc-800 bg-black/20 px-3 py-2">
                <dt className="text-xs text-zinc-500">{label}</dt>
                <dd className="mt-1 text-sm text-zinc-200">{value}</dd>
              </div>
            ))}
          </dl>
          <div className="mt-6 flex flex-wrap items-center gap-3">
            <a href={`/api/tools/${tool.slug}/download`} className="batlab-button inline-flex items-center rounded-full bg-zinc-100 text-zinc-900 px-6 py-3 font-medium">Baixar {tool.file}</a>
            {tool.source && <a href={tool.source} target="_blank" rel="noreferrer" className="batlab-button inline-flex items-center rounded-full border border-zinc-700 px-6 py-3 font-medium hover:bg-zinc-800">Ver código-fonte</a>}
          </div>
          {tool.sourceKind === "database" && tool.code && (
            <>
              <h3 className="mt-6 text-lg font-medium">Código</h3>
              <pre className="mt-2 overflow-x-auto rounded-lg bg-black/40 p-4 text-sm">{tool.code}</pre>
            </>
          )}
          <p className="mt-4 break-all text-xs text-zinc-500">SHA-256: {tool.sha256}</p>
          <p className="mt-1 text-xs text-zinc-500">Versão {tool.version} • {tool.size} • <Link href={`/problems`} className="underline underline-offset-2 hover:text-zinc-300">Ver problemas relacionados</Link></p>
        </div>
      </div>
    </main>
  );
}
