"use client";
import Link from "next/link";

export default function NavBar() {
  return (
    <nav className="border-b border-zinc-800 bg-[#0a0a0b]/80 backdrop-blur sticky top-0 z-50">
      <div className="mx-auto max-w-6xl px-6 h-14 flex items-center justify-between">
        <Link href="/" className="font-semibold tracking-tight">BATLAB</Link>
        <div className="flex items-center gap-4">
          <Link href="/tools" className="text-sm text-zinc-300 hover:text-zinc-100">Ferramentas</Link>
          <Link href="/login" className="text-sm rounded-lg border border-zinc-700 px-3 py-1.5 hover:bg-zinc-800">Entrar</Link>
        </div>
      </div>
    </nav>
  );
}
