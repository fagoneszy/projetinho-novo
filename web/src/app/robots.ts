import type { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  const baseUrl = new URL(process.env.NEXT_PUBLIC_SITE_URL ?? "https://batlab.vercel.app").origin;
  return {
    rules: {
      userAgent: "*",
      allow: ["/", "/problems", "/problems/"],
      disallow: ["/account", "/admin", "/api", "/tools"],
    },
    sitemap: `${baseUrl}/sitemap.xml`,
  };
}
