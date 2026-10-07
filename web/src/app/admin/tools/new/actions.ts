"use server";

import { adminUsers, toolSecurity, tools } from "@/drizzle/schema";
import { db } from "@/lib/db";
import { getSession } from "@/lib/session";
import { analyzeSecurity } from "@/lib/securityAnalyzer";
import { eq } from "drizzle-orm";

type NewToolInput = {
  name: string;
  slug: string;
  description: string;
  category: string;
  type: string;
  script: string;
};

export async function createTool(input: NewToolInput) {
  const session = await getSession();
  if (!session) throw new Error("Unauthorized");

  const [adminRecord] = await db
    .select({ id: adminUsers.id })
    .from(adminUsers)
    .where(eq(adminUsers.userId, session.user.id))
    .limit(1);

  if (!adminRecord) throw new Error("Forbidden");

  const name = input.name.trim();
  const slug = input.slug.trim();
  const description = input.description.trim();
  const category = input.category.trim();
  const type = input.type.trim();
  const script = input.script.trim();

  if (!name || !slug || !description || !category || !type) {
    throw new Error("Nome, slug, descrição, categoria e tipo são obrigatórios.");
  }

  const analysis = analyzeSecurity(script);
  const reasons = analysis.reasons;
  const [tool] = await db
    .insert(tools)
    .values({
      name,
      slug,
      description,
      platform: "Windows",
      severity: "LOW",
      category,
      type,
      code: script,
      status: "published",
      createdBy: session.user.id,
    })
    .returning({ id: tools.id });

  await db.insert(toolSecurity).values({
    toolId: tool.id,
    riskLevel: analysis.riskLevel,
    requiresAdmin: reasons.some((reason) =>
      /Requer Admin|Modifica Registro|Contas de usuário|Serviços/i.test(reason),
    ),
    accessesNetwork: reasons.some((reason) =>
      /Rede|Agenda tarefas|Controle de serviços/i.test(reason),
    ),
    modifiesRegistry: reasons.some((reason) =>
      /Registro|Controle de serviços/i.test(reason),
    ),
    writesFiles: reasons.some((reason) => /Escreve|Cria|Modify/i.test(reason)),
    deletesFiles: reasons.some((reason) =>
      /Deleta|Remove|Limpa|Formata/i.test(reason),
    ),
    executesExternal: reasons.some((reason) =>
      /Executa|WMIC|PowerShell|Rundll32/i.test(reason),
    ),
    downloadsFiles: reasons.some((reason) =>
      /Baixa|Download|Curl|Wget|CertUtil|BitsAdmin/i.test(reason),
    ),
    createsProcesses: reasons.some((reason) =>
      /Cria|Processos|Executa/i.test(reason),
    ),
    detectedPatterns: reasons,
    analysisVersion: analysis.analysisVersion,
    analyzedAt: new Date(analysis.analyzedAt),
  });
}
