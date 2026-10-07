import LoginHero from "@/components/LoginHero";
import { safeReturnTo } from "@/lib/safe-return-to";

export default async function LoginPage({ searchParams }: { searchParams: Promise<{ callbackUrl?: string }> }) {
  const { callbackUrl } = await searchParams;
  return <LoginHero returnTo={safeReturnTo(callbackUrl)} />;
}
