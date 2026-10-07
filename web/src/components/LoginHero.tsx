"use client";
import { motion } from "framer-motion";
import VideoBackground from "./VideoBackground";

export default function LoginHero() {
  return (
    <div className="relative isolate flex min-h-[100dvh] items-center justify-center bg-[#030303] px-4 overflow-hidden">
      <VideoBackground src="/login.mp4" overlay="from-[#030303]/85 via-[#030303]/70 to-[#030303]" />
      <motion.div
        initial={{ y: 20, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.8 }}
        className="relative z-10 w-full max-w-md rounded-2xl border border-zinc-800 bg-zinc-900/60 p-8 backdrop-blur-md shadow-[0_0_80px_rgba(0,0,0,0.5)]"
      >
        <h1 className="text-2xl font-semibold mb-6 text-center text-white">Entrar</h1>
        <a
          href="/api/auth/signin/google"
          className="block w-full rounded-full bg-white text-black text-center py-3 font-medium transition-colors duration-200 hover:bg-zinc-100"
        >
          Continuar com Google
        </a>
        <p className="mt-4 text-xs text-zinc-500 text-center">Ao entrar você aceita os termos de uso.</p>
      </motion.div>
    </div>
  );
}
