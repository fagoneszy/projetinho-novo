"use client";

import { motion } from "framer-motion";
import HeroSearch from "./HeroSearch";
import VideoBackground from "./VideoBackground";

export default function HeroWaves() {
  return (
    <section className="relative isolate flex min-h-[min(70vh,760px)] items-center justify-center overflow-hidden bg-[#030303] px-4 py-16 sm:px-6">
      <VideoBackground
        src="/herosection.mp4"
        overlay="from-[#030303]/75 via-[#030303]/45 to-[#030303]/80"
      />
      <motion.div
        initial={{ y: 16, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.6 }}
        className="relative z-10 w-full max-w-4xl"
      >
        <HeroSearch />
      </motion.div>
    </section>
  );
}
