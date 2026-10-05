export const siteUrl = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";

export const allowedDownloadHosts = [
  "github.com",
  "raw.githubusercontent.com",
];

export function isAllowedDownload(url: string) {
  try {
    const u = new URL(url);
    return allowedDownloadHosts.includes(u.hostname);
  } catch {
    return false;
  }
}
