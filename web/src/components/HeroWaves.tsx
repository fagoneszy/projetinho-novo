"use client";
import { motion } from "framer-motion";
import Link from "next/link";

export default function HeroWaves() {
  return (
    <div className="relative overflow-hidden bg-black px-4">
      {/* Radial Gradient / Spotlight Background */}
      <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.08)_0,transparent_100%)]" />

      {/* Grid Pattern Background */}
      <div className="pointer-events-none absolute inset-0 bg-[linear-gradient(to_right,#80808012_1px,transparent_1px),linear-gradient(to_bottom,#80808012_1px,transparent_1px)] bg-[size:24px_24px] [mask-image:radial-gradient(ellipse_60%_50%_at_50%_50%,#000_70%,transparent_100%)]" />

      <div className="relative z-10 mx-auto max-w-2xl px-6 py-32 text-center">
        

        <motion.h1 initial={{ y: 20, opacity: 0 }} animate={{ y: 0, opacity: 1 }} transition={{ duration: 0.8 }} className="mt-4 text-5xl md:text-6xl font-extrabold tracking-tight text-white sm:text-7xl">
          BATLAB
        </motion.h1>

        <motion.p initial={{ y: 20, opacity: 0 }} animate={{ y: 0, opacity: 1 }} transition={{ duration: 0.8, delay: 0.1 }} className="mt-4 text-base leading-relaxed text-zinc-400 sm:text-lg">
          Catálogo multiplataforma de microutilitários com metadados de segurança.
          <span className="text-white font-medium"> 17 problemas</span> e
          <span className="text-white font-medium"> 400+ ferramentas Windows</span> auditadas.
        </motion.p>

        <motion.div initial={{ y: 20, opacity: 0 }} animate={{ y: 0, opacity: 1 }} transition={{ duration: 0.8, delay: 0.2 }} className="mt-8 flex items-center justify-center gap-4">
          <a href="/tools" className="rounded-lg bg-white px-5 py-2.5 text-sm font-semibold text-black transition hover:bg-zinc-200">
            Explorar ferramentas
          </a>
          <a href="#problemas" className="rounded-lg border border-zinc-800 bg-zinc-900/50 px-5 py-2.5 text-sm font-semibold text-white backdrop-blur-sm transition hover:border-zinc-700 hover:bg-zinc-800">
            Ver problemas
          </a>
        </motion.div>
      </div>
    </div>
  );
}
