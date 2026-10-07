import type { MetadataRoute } from "next";
import { getCatalogProblems } from "@/lib/catalog";

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = new URL(process.env.NEXT_PUBLIC_SITE_URL ?? "https://batlab.vercel.app").origin;
  const staticPages: MetadataRoute.Sitemap = [
    { url: baseUrl, changeFrequency: "weekly", priority: 1 },
    { url: `${baseUrl}/problems`, changeFrequency: "weekly", priority: 0.8 },
  ];
  const problemPages: MetadataRoute.Sitemap = getCatalogProblems().map((problem) => ({
    url: `${baseUrl}/problems/${problem.id}`,
    changeFrequency: "monthly",
    priority: 0.6,
  }));
  return [...staticPages, ...problemPages];
}
