"use client";
import { motion } from "framer-motion";

export default function LoginHero() {
  return (
    <div className="relative flex min-h-[80vh] items-center justify-center bg-[#030303] px-4">
      {/* Textured background */ }
      <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.08)_0,transparent_100%)]" />
      <div className="pointer-events-none absolute inset-0 bg-[repeating-linear-gradient(0deg,#08080810_0px,#08080810_1px,transparent_1px_2px),repeating-linear-gradient(90deg,#08080810_0px,#08080810_1px,transparent_1px_2px)] bg-[size:32px_32px]" />
      <motion.div
        initial={{ y: 20, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.8 }}
        className="relative w-full max-w-md rounded-xl border border-zinc-800 bg-zinc-900/60 p-8 backdrop-blur"
      >
        <h1 className="text-2xl font-semibold mb-6 text-center text-white">Entrar</h1>
        <a href="/api/auth/signin/google" className="block w-full rounded-xl bg-white text-black text-center py-3 font-medium transition-colors duration-200 hover:bg-zinc-100">Continuar com Google</a>
        <p className="mt-4 text-xs text-zinc-500 text-center">Ao entrar você aceita os termos de uso.</p>
      </motion.div>
    </div>
  );
}
