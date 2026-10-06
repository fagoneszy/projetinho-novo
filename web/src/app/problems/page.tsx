import NavBar from "@/components/NavBar";
import Link from "next/link";

const problems = [
  { id: "seguranca", title: "Revisar a segurança do PC", desc: "Auditoria de portas, firewall, contas e eventos." },
  { id: "rede-problemas", title: "Problemas de rede", desc: "Diagnóstico e correção de conectividade." },
  { id: "pc-lento", title: "PC lento", desc: "Otimização e limpeza de desempenho." },
];

export default function ProblemsPage() {
  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-6xl px-6 py-12">
        <h1 className="text-3xl font-semibold mb-6">Problemas</h1>
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {problems.map(p => (
            <Link key={p.id} href={`/problems/${p.id}`} className="border border-zinc-800 rounded-xl p-4 hover:bg-zinc-900">
              <div className="font-medium">{p.title}</div>
              <div className="text-sm text-zinc-400">{p.desc}</div>
            </Link>
          ))}
        </div>
      </div>
    </main>
  );
}
