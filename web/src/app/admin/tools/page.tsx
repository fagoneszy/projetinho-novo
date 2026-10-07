import { redirect } from "next/navigation";
import AdminToolsClient from "./AdminToolsClient";
import { adminUsers, toolSecurity, tools } from "@/drizzle/schema";
import { db } from "@/lib/db";
import { getSession } from "@/lib/session";
import { desc, eq } from "drizzle-orm";

export default async function AdminToolsPage() {
  const session = await getSession();
  if (!session) redirect("/login");

  const [adminRecord] = await db
    .select({ id: adminUsers.id })
    .from(adminUsers)
    .where(eq(adminUsers.userId, session.user.id))
    .limit(1);

  if (!adminRecord) redirect("/");

  const rows = await db
    .select({
      id: tools.id,
      name: tools.name,
      slug: tools.slug,
      description: tools.description,
      status: tools.status,
      categoryName: tools.category,
      riskLevel: toolSecurity.riskLevel,
      createdAt: tools.createdAt,
    })
    .from(tools)
    .leftJoin(toolSecurity, eq(tools.id, toolSecurity.toolId))
    .orderBy(desc(tools.createdAt));

  const initialTools = rows.map((tool) => ({
    ...tool,
    createdAt: tool.createdAt.toISOString(),
  }));

  return <AdminToolsClient initialTools={initialTools} />;
}
