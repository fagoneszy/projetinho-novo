import { pgTable, text, text as pgText } from "drizzle-orm/pg-core";

export const problems = pgTable("problems", {
  id: text("id").primaryKey(),
  title: text("title").notNull(),
  description: text("description"),
  keywords: pgText("keywords").array(),
  tools: pgText("tools").array(),
});
