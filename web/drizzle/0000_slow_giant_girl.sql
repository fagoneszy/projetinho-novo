CREATE TABLE "audit_logs" (
	"id" serial PRIMARY KEY NOT NULL,
	"actor" text,
	"action" text NOT NULL,
	"entity" text,
	"entity_id" text,
	"meta" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "categories" (
	"id" serial PRIMARY KEY NOT NULL,
	"slug" varchar(128) NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"icon" text,
	CONSTRAINT "categories_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "downloads_daily" (
	"script_id" integer NOT NULL,
	"date" text NOT NULL,
	"count" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE "platforms" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"slug" varchar(64) NOT NULL,
	CONSTRAINT "platforms_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "problem_tools" (
	"problem_id" varchar(128) NOT NULL,
	"script_id" integer NOT NULL,
	"position" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE "problems" (
	"id" varchar(128) PRIMARY KEY NOT NULL,
	"slug" varchar(128) NOT NULL,
	"title" text NOT NULL,
	"description" text NOT NULL,
	"position" integer NOT NULL,
	CONSTRAINT "problems_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "releases" (
	"id" serial PRIMARY KEY NOT NULL,
	"script_id" integer NOT NULL,
	"version" varchar(32) NOT NULL,
	"download_url" text NOT NULL,
	"source_url" text,
	"sha256" varchar(64) NOT NULL,
	"file_size" integer,
	"released_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "script_platforms" (
	"script_id" integer NOT NULL,
	"platform_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE "scripts" (
	"id" serial PRIMARY KEY NOT NULL,
	"slug" varchar(128) NOT NULL,
	"name" text NOT NULL,
	"description" text NOT NULL,
	"long_description" text,
	"status" varchar(32) DEFAULT 'active' NOT NULL,
	"license" varchar(64) DEFAULT 'MIT' NOT NULL,
	"risk_level" varchar(16) DEFAULT 'low' NOT NULL,
	"requires_admin" boolean DEFAULT false NOT NULL,
	"writes" varchar(16) DEFAULT 'none' NOT NULL,
	"deletes" varchar(16) DEFAULT 'none' NOT NULL,
	"registry" varchar(16) DEFAULT 'none' NOT NULL,
	"services" varchar(16) DEFAULT 'none' NOT NULL,
	"tasks" varchar(16) DEFAULT 'none' NOT NULL,
	"network" varchar(16) DEFAULT 'none' NOT NULL,
	"restart" varchar(16) DEFAULT 'none' NOT NULL,
	"undo" text,
	"current_version" varchar(32),
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "scripts_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE UNIQUE INDEX "downloads_daily_pk" ON "downloads_daily" USING btree ("script_id","date");--> statement-breakpoint
CREATE UNIQUE INDEX "problem_tools_pk" ON "problem_tools" USING btree ("problem_id","script_id");--> statement-breakpoint
CREATE INDEX "releases_script_version_idx" ON "releases" USING btree ("script_id","version");--> statement-breakpoint
CREATE UNIQUE INDEX "script_platforms_pk" ON "script_platforms" USING btree ("script_id","platform_id");--> statement-breakpoint
CREATE UNIQUE INDEX "scripts_slug_idx" ON "scripts" USING btree ("slug");