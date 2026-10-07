"use client";

import { motion } from "framer-motion";
import HeroSearch from "./HeroSearch";
import VideoBackground from "./VideoBackground";

export default function HeroWaves() {
  return (
    <section className="bg-[#030303] px-4 py-8 sm:px-6 sm:py-12">
      <div className="relative isolate mx-auto flex min-h-[480px] w-full max-w-[748px] items-center justify-center overflow-hidden rounded-3xl border border-white/15 bg-[#030303] shadow-[0_24px_100px_rgba(0,0,0,0.4)] sm:aspect-[374/209] sm:min-h-0">
        <VideoBackground
          src="/herosection.mp4"
          overlay="from-[#030303]/65 via-[#030303]/40 to-[#030303]/70"
        />
        <motion.div
          initial={{ y: 16, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.6 }}
          className="relative z-10 w-full px-4 py-10 sm:px-8"
        >
          <div className="mx-auto mb-6 max-w-2xl text-center">
            <p className="mb-3 text-xs font-semibold uppercase tracking-[0.24em] text-zinc-300">
              Catálogo BATLAB
            </p>
            <h1 className="text-3xl font-semibold tracking-tight text-white sm:text-4xl">
              Encontre e avalie ferramentas em um só lugar.
            </h1>
            <p className="mx-auto mt-3 max-w-xl text-sm leading-relaxed text-zinc-200 sm:text-base">
              Explore o catálogo, filtre por categoria e nível de risco e confira
              informações úteis antes de usar.
            </p>
          </div>
          <HeroSearch />
        </motion.div>
      </div>
    </section>
  );
}
