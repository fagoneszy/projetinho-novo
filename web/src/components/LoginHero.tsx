"use client";
import { motion } from "framer-motion";

export default function LoginHero() {
  return (
    <div className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100 flex items-center justify-center">
      <img src="/login.jpg" alt="Login" className="absolute inset-0 w-full h-full object-cover opacity-20" />
      <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="relative w-full max-w-md rounded-2xl border border-zinc-800 bg-zinc-900/70 p-8 backdrop-blur">
        <h1 className="text-2xl font-semibold mb-6 text-center">Entrar</h1>
        <a href="/api/auth/signin/google" className="block w-full rounded-xl bg-white text-black text-center py-3 font-medium">Continuar com Google</a>
        <p className="mt-4 text-xs text-zinc-500 text-center">Ao entrar você aceita os termos de uso.</p>
      </motion.div>
    </div>
  );
}
