import NavBar from "@/components/NavBar";
import HeroWaves from "@/components/HeroWaves";
import { getCatalogCategories } from "@/lib/catalog";

export default function Home() {
  return (
    <main className="min-h-[100dvh] bg-[#030303] text-zinc-100">
      <NavBar />
      <HeroWaves categories={getCatalogCategories()} />
    </main>
  );
}
