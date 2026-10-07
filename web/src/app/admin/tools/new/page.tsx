import { redirect } from "next/navigation";
import { adminUsers } from "@/drizzle/schema";
import { db } from "@/lib/db";
import { getSession } from "@/lib/session";
import { eq } from "drizzle-orm";
import NewToolForm from "./NewToolForm";

export default async function AdminNewToolPage() {
  const session = await getSession();
  if (!session) redirect("/login");

  const [adminRecord] = await db
    .select({ id: adminUsers.id })
    .from(adminUsers)
    .where(eq(adminUsers.userId, session.user.id))
    .limit(1);

  if (!adminRecord) redirect("/");

  return <NewToolForm />;
}
