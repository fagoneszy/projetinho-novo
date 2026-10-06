import NavBar from "@/components/NavBar";
import Link from "next/link";

async function getProblems() {
  const res = await fetch(`${process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000"}/api/problems`, { cache: "no-store" });
  if (!res.ok) return [];
  const data = await res.json();
  return data.problems ?? [];
}

export default async function ProblemsPage() {
  const problems = await getProblems();
  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-6xl px-6 py-12">
        <h1 className="text-3xl font-semibold mb-6">Problemas</h1>
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {problems.map((p: any) => (
            <Link key={p.id} href={`/problems/${p.id}`} className="border border-zinc-800 rounded-xl p-4 hover:bg-zinc-900">
              <div className="font-medium">{p.title}</div>
              <div className="text-sm text-zinc-400">{p.description}</div>
            </Link>
          ))}
        </div>
      </div>
    </main>
  );
}
