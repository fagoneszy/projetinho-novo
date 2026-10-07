import Link from "next/link";
import VideoBackground from "@/components/VideoBackground";

export default function NotFound() {
  return (
    <main className="relative isolate min-h-[100dvh] flex flex-col items-center justify-center bg-[#030303] text-zinc-100 px-6 overflow-hidden">
      <VideoBackground src="/404NotFound.mp4" overlay="from-black/80 via-black/60 to-black" />
      <div className="relative z-10 text-center">
        <h1 className="text-8xl font-extrabold tracking-tighter text-white mb-4 drop-shadow-[0_0_30px_rgba(255,255,255,0.08)]">
          404
        </h1>
        <h2 className="text-2xl font-semibold text-zinc-200 mb-2">Not Found</h2>
        <p className="mb-8 text-zinc-400 max-w-md mx-auto">
          Essa página não existe no laboratório do BATLAB.
        </p>
        <Link
          href="/"
          className="inline-flex items-center gap-2 rounded-full bg-white text-black px-6 py-3 font-semibold hover:bg-zinc-200 transition"
        >
          Voltar para Home
        </Link>
      </div>
    </main>
  );
}
