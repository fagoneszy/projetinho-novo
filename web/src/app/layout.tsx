import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";

const geistSans = Geist({ variable: "--font-geist-sans", subsets: ["latin"] });
const geistMono = Geist_Mono({ variable: "--font-geist-mono", subsets: ["latin"], preload: false });

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL ?? "https://batlab.vercel.app";

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: {
    default: "BATLAB — Windows Tools",
    template: "%s | BATLAB",
  },
  description: "Biblioteca de ferramentas, scripts e automações para Windows, analisadas e organizadas pelo BATLAB.",
  applicationName: "BATLAB",
  keywords: ["Windows", "BAT", "PowerShell", "scripts", "automação", "ferramentas Windows"],
  authors: [{ name: "BATLAB" }],
  creator: "BATLAB",
  publisher: "BATLAB",
  openGraph: {
    type: "website",
    locale: "pt_BR",
    url: siteUrl,
    siteName: "BATLAB",
    title: "BATLAB — Windows Tools",
    description: "Scripts, ferramentas e automações para Windows, organizados e analisados.",
    images: [{ url: "/og-image.png", width: 1200, height: 630, alt: "BATLAB — Windows Tools" }],
  },
  twitter: {
    card: "summary_large_image",
    title: "BATLAB — Windows Tools",
    description: "Scripts, ferramentas e automações para Windows.",
    images: ["/og-image.png"],
  },
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="pt-BR" className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}>
      <body className="min-h-full flex flex-col">{children}</body>
    </html>
  );
}
