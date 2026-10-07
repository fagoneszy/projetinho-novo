import { notFound } from "next/navigation";
import NavBar from "@/components/NavBar";
import Link from "next/link";
import { db } from "@/lib/db";
import { problems, toolProblems, tools } from "@/drizzle/schema";
import { eq } from "drizzle-orm";

export default async function ProblemDetail({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const [problem] = await db.select().from(problems).where(eq(problems.id, id)).limit(1);
  if (!problem) return notFound();
  const relatedTools = await db
    .select({ slug: tools.slug })
    .from(toolProblems)
    .innerJoin(tools, eq(toolProblems.toolId, tools.id))
    .where(eq(toolProblems.problemId, id));

  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-4xl px-6 py-12">
        <h1 className="text-3xl font-semibold">{problem.name}</h1>
        <p className="mt-2 text-zinc-400">{problem.description}</p>
        <h2 className="mt-8 text-xl font-medium">Ferramentas</h2>
        <div className="grid sm:grid-cols-2 gap-3 mt-4">
          {relatedTools.map(({ slug }) => (
            <Link key={slug} href={`/tools/${slug}`} className="border border-zinc-800 rounded-lg p-3 hover:bg-zinc-900">{slug}</Link>
          ))}
        </div>
      </div>
    </main>
  );
}
