import NavBar from "@/components/NavBar";
import { getSession } from "@/lib/session";
import { redirect } from "next/navigation";
import { db } from "@/lib/db";
import { favorites } from "@/drizzle/schema";
import { eq } from "drizzle-orm";
import Link from "next/link";

export default async function AccountPage() {
  const session = await getSession();
  if (!session) redirect("/login");

  const favs = await db.select().from(favorites).where(eq(favorites.userId, session.user.id));

  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-4xl px-6 py-12">
        <h1 className="text-3xl font-semibold">Minha Conta</h1>
        <div className="mt-6 border border-zinc-800 rounded-xl p-6">
          <p><strong>Nome:</strong> {session.user.name ?? "—"}</p>
          <p><strong>Email:</strong> {session.user.email}</p>
          <a href="/api/auth/signout" className="mt-6 inline-block rounded-lg border border-zinc-700 px-4 py-2">Sair</a>
        </div>
        <h2 className="mt-10 text-2xl font-semibold">Favoritos</h2>
        <div className="grid sm:grid-cols-2 gap-3 mt-4">
          {favs.map(f => (
            <Link key={f.toolSlug} href={`/tools/${f.toolSlug}`} className="border border-zinc-800 rounded-lg p-3 hover:bg-zinc-900">{f.toolSlug}</Link>
          ))}
          {favs.length === 0 && <p className="text-zinc-500">Nenhum favorito ainda.</p>}
        </div>
      </div>
    </main>
  );
}
