import { drizzle } from 'drizzle-orm/neon-http';
import { neon } from '@neondatabase/serverless';

if (!process.env.DATABASE_URL) {
  console.error('DATABASE_URL not set');
  process.exit(1);
}

const sqlClient = neon(process.env.DATABASE_URL);
const db = drizzle(sqlClient);

async function main() {
  try {
    // Create admin_users table
    await db.execute(`
      CREATE TABLE "admin_users" (
        "id" SERIAL PRIMARY KEY,
        "user_id" INTEGER NOT NULL REFERENCES "users"("id"),
        "created_by" INTEGER REFERENCES "users"("id"),
        "created_at" TIMESTAMP NOT NULL DEFAULT NOW()
      )
    `);
    console.log('✅ admin_users table created successfully');
  } catch (err) {
    console.error('❌ Error creating admin_users table:', err);
    process.exit(1);
  }
}

main();