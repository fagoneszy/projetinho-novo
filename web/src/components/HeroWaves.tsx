"use client";
import { motion } from "framer-motion";
import Link from "next/link";

export default function HeroWaves() {
  return (
    <div className="relative overflow-hidden bg-[#0a0a0b]">
      <div className="absolute inset-0">
        {[...Array(3)].map((_, i) => (
          <motion.svg
            key={i}
            className="absolute w-[120%] h-[120%] left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2"
            viewBox="0 0 1000 1000"
            initial={{ rotate: 0, opacity: 0.15 }}
            animate={{ rotate: 360, opacity: [0.12, 0.18, 0.12] }}
            transition={{ duration: 60 + i * 20, repeat: Infinity, ease: "linear" }}
          >
            <defs>
              <radialGradient id={`g${i}`}>
                <stop offset="0%" stopColor="white" stopOpacity="0.25" />
                <stop offset="100%" stopColor="white" stopOpacity="0" />
              </radialGradient>
            </defs>
            <circle cx="500" cy="500" r={200 + i * 120} fill={`url(#g${i})`} />
          </motion.svg>
        ))}
      </div>
      <div className="relative z-10 mx-auto max-w-6xl px-6 py-32 text-center">
        <motion.h1
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.8 }}
          className="text-5xl md:text-7xl font-semibold tracking-tight text-zinc-100"
        >
          BATLAB
        </motion.h1>
        <motion.p
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.1 }}
          className="mt-6 text-lg text-zinc-400 max-w-2xl mx-auto"
        >
          Catálogo multiplataforma de microutilitários com metadados de segurança. 17 problemas, 400+ ferramentas Windows auditadas.
        </motion.p>
        <motion.div
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.2 }}
          className="mt-10 flex justify-center gap-4"
        >
          <Link href="/tools" className="rounded-xl bg-zinc-100 text-zinc-900 px-6 py-3 font-medium">Explorar ferramentas</Link>
          <a href="#problemas" className="rounded-xl border border-zinc-700 px-6 py-3 font-medium text-zinc-200">Ver problemas</a>
        </motion.div>
      </div>
    </div>
  );
}
