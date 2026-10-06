import { drizzle } from 'drizzle-orm/neon-http';
import { neon } from '@neondatabase/serverless';
import { sql } from 'drizzle-orm';
import { users } from './src/drizzle/schema.ts';

if (!process.env.DATABASE_URL) {
  console.error('DATABASE_URL not set');
  process.exit(1);
}

const sqlClient = neon(process.env.DATABASE_URL);
const db = drizzle(sqlClient);

async function main() {
  try {
    // Find user by email
    const [user] = await db
      .select({ id: users.id })
      .from(users)
      .where(sql`${users.email} = ${process.env.ADMIN_EMAIL || 'fagnervieiradasilva3@gmail.com'}`)
      .limit(1);

    if (!user) {
      console.error('❌ User not found with email:', process.env.ADMIN_EMAIL || 'fagnervieiradasilva3@gmail.com');
      process.exit(1);
    }

    // Insert admin record
    await db.execute(sql`
      INSERT INTO "admin_users" ("user_id", "created_by")
      VALUES (${user.id}, ${user.id})
      ON CONFLICT DO NOTHING
    `);

    console.log(`✅ Admin access granted to user ID ${user.id} (email: ${process.env.ADMIN_EMAIL || 'fagnervieiradasilva3@gmail.com'})`);
  } catch (err) {
    console.error('❌ Error granting admin access:', err);
    process.exit(1);
  }
}

main();