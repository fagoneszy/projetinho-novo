"use client";
import { motion } from "framer-motion";
import Link from "next/link";

export default function HeroWaves() {
  return (
    <div className="relative flex min-h-[80vh] flex-col items-center justify-center overflow-hidden bg-[#030303] px-4 text-center">
      {/* 1. Fundo Texturizado e Spotlight (Sutil) */}
      <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.08)_0,transparent_100%)]" />
      <div className="pointer-events-none absolute inset-0 bg-[repeating-linear-gradient(0deg,#08080810_0px,#08080810_1px,transparent_1px_2px),repeating-linear-gradient(90deg,#08080810_0px,#08080810_1px,transparent_1px_2px)] bg-[size:32px_32px]" />
      {/* 2. Conteúdo com Tipografia e Hierarquia Refinada */}
      <div className="relative z-10 max-w-4xl">
        {/* Badge de Status sutil */}
        <span className="inline-flex items-center gap-2 rounded-full border border-zinc-800 bg-zinc-900/80 px-3 py-1 text-xs text-zinc-400 backdrop-blur-sm">
          <span className="h-1.5 w-1.5 rounded-full bg-emerald-500 animate-pulse" />
          400+ Ferramentas Auditadas
        </span>
        {/* Título Principal Bold e Grande */}
        <h1 className="mt-6 text-6xl font-extrabold tracking-tighter text-white sm:text-7xl">
          BATLAB
        </h1>
        {/* Subtítulo Suavizado */}
        <p className="mt-6 text-base leading-relaxed text-zinc-400 sm:text-xl">
          Catálogo multiplataforma de microutilitários com metadados de segurança.
          <span className="text-white font-medium"> 17 problemas </span> e 
          <span className="text-white font-medium"> 400+ ferramentas Windows </span> auditadas.
        </p>
        {/* 3. Botões com Estilos de Referência */}
        <div className="mt-10 flex items-center justify-center gap-4">
          <button className="rounded-lg bg-white px-6 py-3 text-sm font-semibold text-black transition-all duration-300 hover:bg-zinc-200 hover:shadow-[0_0_15px_rgba(255,255,255,0.2)]">
            Explorar ferramentas
          </button>
          <button className="flex items-center gap-2 rounded-lg border border-zinc-800 bg-zinc-900/50 px-6 py-3 text-sm font-semibold text-white backdrop-blur-sm transition-all duration-300 hover:border-zinc-700 hover:bg-zinc-800">
            {/* Ícone sutil antes do texto */}
            <svg className="h-4 w-4 text-zinc-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
            </svg>
            Ver problemas
          </button>
        </div>
        {/* Animação de entrada com Framer Motion */}
        <motion.div
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.2 }}
          className="mt-4 text-xs text-zinc-500"
        >
          Pronto para executar com segurança e confiança
        </motion.div>
      </div>
    </div>
  );
}
