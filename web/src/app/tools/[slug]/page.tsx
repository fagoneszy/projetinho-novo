import { notFound } from "next/navigation";
import NavBar from "@/components/NavBar";
import { db } from "@/lib/db";
import { tools } from "@/drizzle/schema";
import { eq } from "drizzle-orm";

export default async function ToolDetail({ params }: { params: { slug: string } }) {
  const { slug } = params;
  const [tool] = await db.select().from(tools).where(eq(tools.slug, slug)).limit(1);
  if (!tool) return notFound();

  const meta = tool.securityMeta as any ?? {};
  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-4xl px-6 py-12">
        <h1 className="text-4xl font-semibold">{tool.name}</h1>
        <p className="mt-2 text-zinc-400">{tool.category} • {tool.severity} • {tool.platform}</p>
        <div className="mt-8 rounded-2xl border border-zinc-800 bg-zinc-900/40 p-6">
          <h2 className="text-xl font-medium mb-4">Descrição</h2>
          <p className="text-zinc-300">{tool.description}</p>
          <h3 className="mt-6 text-lg font-medium">Metadados de segurança</h3>
          <div className="flex flex-wrap gap-2 mt-3">
            {Object.entries(meta).map(([k,v]) => (
              <span key={k} className="text-xs bg-zinc-800 border border-zinc-700 rounded-full px-3 py-1">{k}: {String(v)}</span>
            ))}
          </div>
          <h3 className="mt-6 text-lg font-medium">Código</h3>
          <pre className="mt-2 bg-black/40 p-4 rounded-lg text-sm overflow-x-auto">{tool.code ?? "—"}</pre>
          <div className="mt-6">
            <a href={`/api/tools/${tool.slug}/download`} className="batlab-button inline-flex items-center rounded-full bg-zinc-100 text-zinc-900 px-6 py-3 font-medium">Baixar .BAT</a>
          </div>
        </div>
      </div>
    </main>
  );
}
