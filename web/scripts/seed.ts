import { readFile } from "node:fs/promises";
import { join } from "node:path";

export async function seed() {
  const projectsPath = join(process.cwd(), "..", "site", "projects.json");
  const data = await readFile(projectsPath, "utf-8");
  const tools: unknown[] = JSON.parse(data);
  console.log(`seed: ${tools.length} tools`);
}
seed().then(()=>process.exit(0));
