import { pgTable, serial, text, timestamp, jsonb, integer } from "drizzle-orm/pg-core";

export const users = pgTable("users", {
  id: serial("id").primaryKey(),
  googleSub: text("google_sub").notNull().unique(),
  email: text("email").notNull(),
  name: text("name"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export const tools = pgTable("tools", {
  id: serial("id").primaryKey(),
  slug: text("slug").notNull().unique(),
  name: text("name").notNull(),
  description: text("description"),
  platform: text("platform").notNull(),
  severity: text("severity").notNull(),
  category: text("category").notNull(),
  type: text("type").notNull(),
  code: text("code"),
  securityMeta: jsonb("security_meta"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export const problems = pgTable("problems", {
  id: text("id").primaryKey(),
  title: text("title").notNull(),
  description: text("description"),
  keywords: text("keywords").array(),
  tools: text("tools").array(),
});

export const favorites = pgTable("favorites", {
  id: serial("id").primaryKey(),
  userId: integer("user_id").notNull(),
  toolSlug: text("tool_slug").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});
