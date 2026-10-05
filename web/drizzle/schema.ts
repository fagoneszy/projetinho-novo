import { pgTable, serial, text, varchar, timestamp, boolean, integer, uniqueIndex, index } from "drizzle-orm/pg-core";

export const categories = pgTable("categories", {
  id: serial("id").primaryKey(),
  slug: varchar("slug", { length: 128 }).notNull().unique(),
  name: text("name").notNull(),
  description: text("description"),
  icon: text("icon"),
});

export const platforms = pgTable("platforms", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  slug: varchar("slug", { length: 64 }).notNull().unique(),
});

export const scripts = pgTable("scripts", {
  id: serial("id").primaryKey(),
  slug: varchar("slug", { length: 128 }).notNull().unique(),
  name: text("name").notNull(),
  description: text("description").notNull(),
  longDescription: text("long_description"),
  status: varchar("status", { length: 32 }).notNull().default("active"),
  license: varchar("license", { length: 64 }).notNull().default("MIT"),
  riskLevel: varchar("risk_level", { length: 16 }).notNull().default("low"),
  requiresAdmin: boolean("requires_admin").notNull().default(false),
  writes: varchar("writes", { length: 16 }).notNull().default("none"),
  deletes: varchar("deletes", { length: 16 }).notNull().default("none"),
  registry: varchar("registry", { length: 16 }).notNull().default("none"),
  services: varchar("services", { length: 16 }).notNull().default("none"),
  tasks: varchar("tasks", { length: 16 }).notNull().default("none"),
  network: varchar("network", { length: 16 }).notNull().default("none"),
  restart: varchar("restart", { length: 16 }).notNull().default("none"),
  undo: text("undo"),
  currentVersion: varchar("current_version", { length: 32 }),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
}, (t) => [uniqueIndex("scripts_slug_idx").on(t.slug)]);

export const scriptPlatforms = pgTable("script_platforms", {
  scriptId: integer("script_id").notNull(),
  platformId: integer("platform_id").notNull(),
}, (t) => [uniqueIndex("script_platforms_pk").on(t.scriptId, t.platformId)]);

export const releases = pgTable("releases", {
  id: serial("id").primaryKey(),
  scriptId: integer("script_id").notNull(),
  version: varchar("version", { length: 32 }).notNull(),
  downloadUrl: text("download_url").notNull(),
  sourceUrl: text("source_url"),
  sha256: varchar("sha256", { length: 64 }).notNull(),
  fileSize: integer("file_size"),
  releasedAt: timestamp("released_at").defaultNow(),
}, (t) => [
  index("releases_script_version_idx").on(t.scriptId, t.version)
]);

export const problems = pgTable("problems", {
  id: varchar("id", { length: 128 }).primaryKey(),
  slug: varchar("slug", { length: 128 }).notNull().unique(),
  title: text("title").notNull(),
  description: text("description").notNull(),
  position: integer("position").notNull(),
});

export const problemTools = pgTable("problem_tools", {
  problemId: varchar("problem_id", { length: 128 }).notNull(),
  scriptId: integer("script_id").notNull(),
  position: integer("position").notNull(),
}, (t) => [uniqueIndex("problem_tools_pk").on(t.problemId, t.scriptId)]);

export const downloadsDaily = pgTable("downloads_daily", {
  scriptId: integer("script_id").notNull(),
  date: text("date").notNull(), // YYYY-MM-DD
  count: integer("count").notNull().default(0),
}, (t) => [uniqueIndex("downloads_daily_pk").on(t.scriptId, t.date)]);

export const auditLogs = pgTable("audit_logs", {
  id: serial("id").primaryKey(),
  actor: text("actor"),
  action: text("action").notNull(),
  entity: text("entity"),
  entityId: text("entity_id"),
  meta: text("meta"),
  createdAt: timestamp("created_at").defaultNow(),
});
