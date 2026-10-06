import NavBar from "@/components/NavBar";
import HeroWaves from "@/components/HeroWaves";
import ToolsCatalog from "@/components/ToolsCatalog";
import { db } from "@/lib/db";
import { tools } from "@/drizzle/schema";
import { count } from "drizzle-orm";

async function getToolCount() {
  try {
    const [result] = await db.select({ count: count() }).from(tools);
    return Number(result?.count ?? 0);
  } catch {
    return 0;
  }
}

export default async function Home() {
  const countTools = await getToolCount();
  const display = countTools > 0 ? `${countTools}+` : "400+";
  return (
    <main className="min-h-[100dvh] bg-[#030303] text-zinc-100">
      <NavBar />
      <HeroWaves />
      <ToolsCatalog />
    </main>
  );
}
