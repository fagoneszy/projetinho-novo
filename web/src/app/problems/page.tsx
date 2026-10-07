import NavBar from "@/components/NavBar";
import Link from "next/link";
import { getCatalogProblems } from "@/lib/catalog";

export default async function ProblemsPage() {
  const problems = getCatalogProblems();
  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-6xl px-6 py-12">
        <h1 className="text-3xl font-semibold mb-6">Problemas</h1>
        <p className="mb-6 text-sm text-zinc-400">{problems.length} situações com ferramentas relacionadas.</p>
        {problems.length > 0 ? (
          <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {problems.map((problem) => (
              <Link key={problem.id} href={`/problems/${problem.id}`} className="border border-zinc-800 rounded-xl p-4 hover:bg-zinc-900">
                <div className="font-medium">{problem.title}</div>
                <div className="mt-2 text-sm text-zinc-400">{problem.desc}</div>
                <div className="mt-4 text-xs text-zinc-500">{problem.tools.length} ferramentas relacionadas</div>
              </Link>
            ))}
          </div>
        ) : (
          <div className="rounded-2xl border border-zinc-800 bg-zinc-900/40 px-6 py-12 text-center">
            <p className="text-zinc-300">Ainda não há problemas cadastrados.</p>
          </div>
        )}
      </div>
    </main>
  );
}
