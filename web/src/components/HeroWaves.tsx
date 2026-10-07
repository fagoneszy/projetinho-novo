"use client";

import { motion } from "framer-motion";
import HeroSearch from "./HeroSearch";
import VideoBackground from "./VideoBackground";

export default function HeroWaves() {
  return (
    <section className="bg-[#030303] px-4 py-8 sm:px-6 sm:py-10">
      <div className="relative isolate mx-auto flex aspect-video min-h-[320px] w-full max-w-7xl items-center justify-center overflow-hidden rounded-3xl border border-white/15 bg-[#030303] shadow-[0_24px_100px_rgba(0,0,0,0.4)] sm:min-h-0">
        <VideoBackground
          src="/herosection.mp4"
          overlay="from-[#030303]/75 via-[#030303]/45 to-[#030303]/80"
        />
        <motion.div
          initial={{ y: 16, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.6 }}
          className="relative z-10 w-full max-w-4xl px-4 sm:px-8"
        >
          <HeroSearch />
        </motion.div>
      </div>
    </section>
  );
}
