import { createMiddlewareSupabaseClient } from "@supabase/auth-helpers-nextjs";
import Nav from "navigation/Nav";
import { NextURL } from "next/dist/server/web/next-url";
import { NextRequest, NextResponse } from "next/server";
import { Database } from "types/supabase";
import { devLog } from "util/debug";

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * * _next/static (static files)
     * * _next/image (image files)
     * * images (image files)
     * * locales (translation files)
     * * *.ico, *.png, *.svg, *.webmanifest, *.xml (favicon etc.)
     */
    "/((?!_next\\/static|_next\\/image|locales|images|[^\\/]+\\.(?:ico|png|svg|webmanifest|xml)).*)",
    // Also match root path
    "/",
  ],
};

export async function middleware(req: NextRequest) {
  devLog("Middleware processing", req.nextUrl.pathname);

  const res = NextResponse.next();
  const supabase = createMiddlewareSupabaseClient<Database>({ req, res });
  const {
    data: { session },
  } = await supabase.auth.getSession();
  const hasSession = !!session;

  if (hasSession) {
    switch (req.nextUrl.pathname) {
      case Nav().Index.href:
      case Nav().Login.href:
        let redirectTo = req.nextUrl.searchParams.get("redirectedFrom") ?? "";
        if (!redirectTo.startsWith("/secure/")) {
          redirectTo = Nav().secure.Index.href;
        }
        return redirect(redirectTo);
    }
  } else if (!hasSession && req.nextUrl.pathname.startsWith("/secure/")) {
    const redirectUrl = req.nextUrl.clone();
    redirectUrl.pathname = Nav().Index.href;
    redirectUrl.searchParams.set("redirectedFrom", req.nextUrl.pathname);
    return redirect(redirectUrl);
  }

  devLog("Middleware took no action");
}

function redirect(
  url: string | NextURL | URL,
  init?: number | ResponseInit
): NextResponse {
  if (typeof url === "string") {
    devLog("Middleware redirect to", url);
  } else {
    devLog("Middleware redirect to", url.href);
  }
  return NextResponse.redirect(url, init);
}
