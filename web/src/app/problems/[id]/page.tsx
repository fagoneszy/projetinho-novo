import { notFound } from "next/navigation";
import NavBar from "@/components/NavBar";
import Link from "next/link";
import { getCatalogProblem, getProblemTools } from "@/lib/catalog";

export default async function ProblemDetail({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const problem = getCatalogProblem(id);
  if (!problem) return notFound();
  const relatedTools = getProblemTools(problem);

  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-4xl px-6 py-12">
        <h1 className="text-3xl font-semibold">{problem.title}</h1>
        <p className="mt-2 text-zinc-400">{problem.desc}</p>
        <h2 className="mt-8 text-xl font-medium">Ferramentas relacionadas ({relatedTools.length})</h2>
        {relatedTools.length > 0 ? (
          <div className="grid sm:grid-cols-2 gap-3 mt-4">
            {relatedTools.map((tool) => (
              <Link key={tool.slug} href={`/tools/${tool.slug}`} className="border border-zinc-800 rounded-lg p-3 hover:bg-zinc-900">
                <span className="font-medium">{tool.name}</span>
                <span className="mt-1 block text-sm text-zinc-400">{tool.description}</span>
              </Link>
            ))}
          </div>
        ) : (
          <p className="mt-4 text-zinc-400">Ainda não há ferramentas relacionadas a este problema.</p>
        )}
      </div>
    </main>
  );
}
