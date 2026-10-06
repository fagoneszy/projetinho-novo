import Link from "next/link";

export default function NotFound() {
  return (
    <main className="min-h-[80vh] flex flex-col items-center justify-center bg-[#030303] text-zinc-100 px-6">
      <div className="text-center">
        <h1 className="text-4xl font-bold mb-4">404</h1>
        <p className="mb-6 text-zinc-400">
          Essa página não existe no laboratório do BATLAB.
        </p>
        <Link href="/" className="inline-flex items-center gap-2 rounded-lg bg-white text-black px-4 py-2 font-medium hover:bg-zinc-100 transition-colors duration-200">
          Voltar para a Home
        </Link>
      </div>
    </main>
  );
}
