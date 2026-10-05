import { drizzle } from "drizzle-orm/neon-http";
import { neon } from "@neondatabase/serverless";

if (!process.env.DATABASE_URL) {
  // dev fallback
}
const sql = process.env.DATABASE_URL ? neon(process.env.DATABASE_URL) : undefined;
export const db = sql ? drizzle(sql) : null as unknown as ReturnType<typeof drizzle>;
