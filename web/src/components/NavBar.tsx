import Link from "next/link";
import { getSession } from "@/lib/session";
import { Button } from "@/components/ui/button";

export default async function NavBar() {
  const session = await getSession();
  return (
    <nav className="border-b border-zinc-900/50 bg-[#030303]/80 backdrop-blur-sm sticky top-0 z-50">
      <div className="mx-auto max-w-6xl px-6 h-14 flex items-center justify-between">
        <Link href="/" className="font-extrabold tracking-tighter text-white">BATLAB</Link>
        <div className="flex items-center gap-4">
          <Link href="/tools" className="text-sm text-zinc-300 hover:text-zinc-100 transition-colors duration-200">Ferramentas</Link>
          {session?.user ? (
            <span className="text-sm text-zinc-300">{session.user.name ?? session.user.email}</span>
          ) : (
            <Link href="/login" className="text-sm rounded-lg border border-zinc-700 bg-zinc-900/50 px-3 py-1.5 hover:bg-zinc-800 hover:border-zinc-600 transition-colors duration-200">Entrar</Link>
          )}
        </div>
      </div>
    </nav>
  );
}
