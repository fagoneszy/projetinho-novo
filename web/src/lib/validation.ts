import { z } from "zod";

export const slugSchema = z.string().regex(/^[a-z0-9]+$/);
export const riskSchema = z.enum(["low","medium","high","critical"]);
export const writesSchema = z.enum(["none","temp","user","system"]);
export const deletesSchema = z.enum(["none","temp","files"]);
export const enum3 = z.enum(["none","read","write"]);

export const scriptInputSchema = z.object({
  slug: slugSchema,
  risk: riskSchema.optional(),
  admin: z.boolean().optional(),
});

export type ScriptInput = z.infer<typeof scriptInputSchema>;
