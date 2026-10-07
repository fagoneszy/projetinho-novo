"use client";

import { motion } from "framer-motion";
import HeroSearch from "./HeroSearch";
import TerminalCodeBackground from "./TerminalCodeBackground";

export default function HeroWaves() {
  return (
    <section className="relative isolate flex min-h-[min(82vh,820px)] items-center justify-center overflow-hidden bg-black px-4 py-20 sm:px-6">
      <TerminalCodeBackground />
      <div
        aria-hidden="true"
        className="pointer-events-none absolute left-1/2 top-1/2 z-0 h-[420px] w-[min(90vw,900px)] -translate-x-1/2 -translate-y-1/2 rounded-full bg-cyan-300/[0.07] blur-[120px]"
      />
      <motion.div
        initial={{ y: 18, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.65 }}
        className="relative z-10 w-full max-w-5xl"
      >
        <div className="mx-auto mb-9 max-w-4xl text-center sm:mb-11">
          <p className="mb-5 inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/[0.04] px-4 py-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-zinc-300 shadow-[0_0_30px_rgba(34,211,238,0.08)] sm:text-xs">
            <span className="h-1.5 w-1.5 rounded-full bg-cyan-300 shadow-[0_0_12px_rgba(103,232,249,0.9)]" />
            Catálogo de ferramentas auditadas
          </p>
          <h1 className="text-balance text-4xl font-semibold leading-[1.06] tracking-[-0.055em] text-white sm:text-6xl lg:text-7xl">
            Encontre a ferramenta certa.
            <span className="mt-1 block bg-gradient-to-r from-cyan-200 via-white to-violet-200 bg-clip-text text-transparent">
              Entenda antes de executar.
            </span>
          </h1>
          <p className="mx-auto mt-6 max-w-2xl text-pretty text-base leading-7 text-zinc-400 sm:text-lg">
            Explore utilitários, compare categorias e consulte informações de
            segurança para escolher com mais confiança.
          </p>
        </div>
        <div className="mx-auto max-w-3xl">
          <HeroSearch />
        </div>
      </motion.div>
    </section>
  );
}
