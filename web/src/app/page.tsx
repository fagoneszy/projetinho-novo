import HeroWaves from "@/components/HeroWaves";
import ToolsCatalog from "@/components/ToolsCatalog";
import NavBar from "@/components/NavBar";

export default function Home() {
  return (
    <main className="min-h-[100dvh] bg-[#0a0a0b] text-zinc-100">
      <NavBar />
      <HeroWaves />
      <ToolsCatalog />
    </main>
  );
}
