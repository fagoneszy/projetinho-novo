import NavBar from "@/components/NavBar";
import { getSession } from "@/lib/session";
import { redirect } from "next/navigation";

export default async function AccountPage() {
  const session = await getSession();
  if (!session) redirect("/login");

  return (
    <main className="min-h-[100dvh] bg-[#030303] text-zinc-100">
      <NavBar />
      <div className="mx-auto max-w-4xl px-6 py-16">
        <h1 className="text-3xl font-semibold text-center mb-8">Minha Conta</h1>
        <div className="bg-zinc-900/50 rounded-xl p-8">
          <p><strong>Nome:</strong> {session.user.name ?? "Não informado"}</p>
          <p><strong>Email:</strong> {session.user.email}</p>
          {session.user.avatarUrl && (
            <div className="mt-4">
              <img src={session.user.avatarUrl} alt="Avatar" className="w-24 h-24 rounded-full" />
            </div>
          )}
          <p className="mt-4"><strong>ID:</strong> {session.user.id}</p>
          <a href="/api/auth/signout" className="mt-6 inline-block rounded-lg border border-zinc-700 px-4 py-2 text-sm">Sair</a>
        </div>
      </div>
    </main>
  );
}
