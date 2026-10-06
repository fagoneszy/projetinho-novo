import { pgTable, serial, text, timestamp, jsonb, integer, boolean } from "drizzle-orm/pg-core";

export const users = pgTable("users", {
  id: serial("id").primaryKey(),
  googleSub: text("google_sub").notNull().unique(),
  email: text("email").notNull(),
  name: text("name"),
  avatarUrl: text("avatar_url"),
  bio: text("bio"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const tools = pgTable("tools", {
  id: serial("id").primaryKey(),
  slug: text("slug").notNull().unique(),
  name: text("name").notNull(),
  description: text("description"),
  platform: text("platform").notNull(),
  severity: text("severity").notNull(),
  category: text("category").notNull(), // Keeping as text for now to maintain compatibility
  type: text("type").notNull(),
  code: text("code"),
  securityMeta: jsonb("security_meta"),
  status: text("status").notNull().default("draft"), // draft, analyzing, review, published
  createdBy: integer("created_by").references(() => users.id),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const problems = pgTable("problems", {
  id: text("id").primaryKey(),
  name: text("name").notNull().unique(),
  slug: text("slug").notNull().unique(),
  description: text("description"),
});

export const categories = pgTable("categories", {
  id: serial("id").primaryKey(),
  name: text("name").notNull().unique(),
  slug: text("slug").notNull().unique(),
  description: text("description"),
});

export const tags = pgTable("tags", {
  id: serial("id").primaryKey(),
  name: text("name").notNull().unique(),
});

export const toolTags = pgTable("tool_tags", {
  id: serial("id").primaryKey(),
  toolId: integer("tool_id").notNull().references(() => tools.id),
  tagId: integer("tag_id").notNull().references(() => tags.id),
});

export const toolProblems = pgTable("tool_problems", {
  id: serial("id").primaryKey(),
  toolId: integer("tool_id").notNull().references(() => tools.id),
  problemId: text("problem_id").notNull().references(() => problems.id),
});

export const toolSecurity = pgTable("tool_security", {
  id: serial("id").primaryKey(),
  toolId: integer("tool_id").notNull().references(() => tools.id),
  riskLevel: text("risk_level").notNull(), // LOW, MEDIUM, HIGH
  requiresAdmin: boolean("requires_admin").notNull().default(false),
  accessesNetwork: boolean("accesses_network").notNull().default(false),
  modifiesRegistry: boolean("modifies_registry").notNull().default(false),
  writesFiles: boolean("writes_files").notNull().default(false),
  deletesFiles: boolean("deletes_files").notNull().default(false),
  executesExternal: boolean("executes_external").notNull().default(false),
  downloadsFiles: boolean("downloads_files").notNull().default(false),
  createsProcesses: boolean("creates_processes").notNull().default(false),
  detectedPatterns: jsonb("detected_patterns"),
  analysisVersion: text("analysis_version").notNull().default("1.0"),
  analyzedAt: timestamp("analyzed_at").defaultNow().notNull(),
});

// Admin users table
export const adminUsers = pgTable("admin_users", {
  id: serial("id").primaryKey(),
  userId: integer("user_id").notNull().references(() => users.id),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  createdBy: integer("created_by").references(() => users.id), // Who made them admin
});

// Sessions table (from previous implementation)
export const sessions = pgTable("sessions", {
  id: serial("id").primaryKey(),
  tokenHash: text("token_hash").notNull().unique(),
  userId: integer("user_id").notNull().references(() => users.id),
  expiresAt: timestamp("expires_at").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  lastSeenAt: timestamp("last_seen_at").defaultNow().notNull(),
});

export const favorites = pgTable("favorites", {
  id: serial("id").primaryKey(),
  userId: integer("user_id").notNull().references(() => users.id),
  toolSlug: text("tool_slug").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export const downloads = pgTable("downloads", {
  id: serial("id").primaryKey(),
  userId: integer("user_id").notNull().references(() => users.id),
  toolSlug: text("tool_slug").notNull(),
  downloadedAt: timestamp("downloaded_at").defaultNow().notNull(),
  ipHash: text("ip_hash"),
});
