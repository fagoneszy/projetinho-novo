import Link from "next/link";
import { getSession } from "@/lib/session";
import { redirect } from "next/navigation";
import { db } from "@/lib/db";
import { tools, toolSecurity, adminUsers, categories } from "@/drizzle/schema";
import { eq } from "drizzle-orm";

export default async function AdminDashboard() {
  const session = await getSession();
  if (!session) redirect("/login");

  // Check if user is admin
  const [adminRecord] = await db
    .select()
    .from(adminUsers)
    .where(eq(adminUsers.userId, session.user.id))
    .limit(1);

  if (!adminRecord) redirect("/");

  // Fetch statistics
  const [toolsCount, publishedCount, draftCount, pendingCount] = await Promise.all([
    db.select({ count: db.count() }).from(tools),
    db.select({ count: db.count() }).from(tools).where(eq(tools.status, "published")),
    db.select({ count: db.count() }).from(tools).where(eq(tools.status, "draft")),
    db.select({ count: db.count() }).from(tools).where(eq(tools.status, "review")), // pending review
  ]);

  // Fetch recent tools
  const recentTools = await db
    .select({
      id: tools.id,
      name: tools.name,
      slug: tools.slug,
      status: tools.status,
      createdAt: tools.createdAt,
      riskLevel: toolSecurity.riskLevel,
    })
    .from(tools)
    .leftJoin(toolSecurity, eq(tools.id, toolSecurity.toolId))
    .orderBy(tools.createdAt.desc())
    .limit(5);

  return (
    <main className="min-h-[100dvh] bg-[#030303] text-zinc-100">
      <div className="mx-auto max-w-4xl px-6 py-12">
        <Link href="/admin" className="text-sm text-zinc-400 mb-4 inline-block">
          ← Voltar ao Painel
        </Link>
        <h1 className="text-2xl font-semibold mb-6">BATLAB ADMIN</h1>
        
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
          <div className="bg-zinc-900/50 rounded-xl p-4 border border-zinc-800">
            <h3 className="text-lg font-semibold mb-2">{toolsCount[0]?.count || 0}</h3>
            <p className="text-sm text-zinc-400">Tools</p>
          </div>
          <div className="bg-zinc-900/50 rounded-xl p-4 border border-zinc-800">
            <h3 className="text-lg font-semibold mb-2">{publishedCount[0]?.count || 0}</h3>
            <p className="text-sm text-zinc-400">Publicadas</p>
          </div>
          <div className="bg-zinc-900/50 rounded-xl p-4 border border-zinc-800">
            <h3 className="text-lg font-semibold mb-2">{draftCount[0]?.count || 0}</h3>
            <p className="text-sm text-zinc-400">Rascunhos</p>
          </div>
          <div className="bg-zinc-900/50 rounded-xl p-4 border border-zinc-800">
            <h3 className="text-lg font-semibold mb-2">{pendingCount[0]?.count || 0}</h3>
            <p className="text-sm text-zinc-400">Em Revisão</p>
          </div>
        </div>
        
        <div className="space-y-6">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-xl font-semibold">Ferramentas Recentes</h2>
            <Link href="/admin/tools" className="text-sm text-zinc-400 hover:text-zinc-300">
              Ver todas
            </Link>
          </div>
          
          {recentTools.length > 0 ? (
            <div className="space-y-3">
              {recentTools.map((tool) => (
                <div key={tool.id} className="flex items-center justify-between p-3 bg-zinc-900/30 rounded-xl border border-zinc-800/50">
                  <div className="flex items-center space-x-3">
                    <div className="w-8 h-8 bg-zinc-800/50 rounded-lg flex items-center justify-center text-zinc-400">
                      {/* Icon based on status */}
                      {tool.status === "published" ? "✓" : tool.status === "draft" ? "◌" : "⟳"}
                    </div>
                    <div>
                      <p className="font-medium text-white">{tool.name}</p>
                      <p className="text-sm text-zinc-400">{tool.slug}</p>
                    </div>
                  </div>
                  <div className="flex items-center space-x-2">
                    <div className={`w-2.5 h-2.5 rounded-full ${tool.riskLevel === "LOW" ? "bg-emerald-500" : tool.riskLevel === "MEDIUM" ? "bg-amber-500" : tool.riskLevel === "HIGH" ? "bg-rose-500" : "bg-zinc-500"}`} />
                    <span className="text-xs ml-1">{tool.riskLevel || "N/A"}</span>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-zinc-500 text-center py-8">Nenhuma ferramenta encontrada</p>
          )}
        </div>
      </div>
    </main>
  );
}
