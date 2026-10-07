"use client";

import { motion, useReducedMotion } from "framer-motion";
import HeroSearch from "./HeroSearch";
import TerminalCodeBackground from "./TerminalCodeBackground";

type CategoryOption = { slug: string; label: string };

export default function HeroWaves({ categories }: { categories: CategoryOption[] }) {
  const reduceMotion = useReducedMotion();

  return (
    <section className="relative isolate flex min-h-[min(82vh,820px)] items-center justify-center bg-black px-4 py-20 sm:px-6">
      <div aria-hidden="true" className="pointer-events-none absolute inset-0 z-0 overflow-hidden">
        <TerminalCodeBackground />
        <div className="absolute left-1/2 top-1/2 h-[420px] w-[min(90vw,900px)] -translate-x-1/2 -translate-y-1/2 rounded-full bg-cyan-300/[0.07] blur-[120px]" />
      </div>
      <motion.div
        initial={reduceMotion ? false : { y: 18, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: reduceMotion ? 0 : 0.65 }}
        className="relative z-10 w-full max-w-5xl"
      >
        <div className="mx-auto mb-9 max-w-4xl text-center sm:mb-11">
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
          <HeroSearch categories={categories} />
        </div>
      </motion.div>
    </section>
  );
}
