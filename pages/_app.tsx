import { createBrowserSupabaseClient } from "@supabase/auth-helpers-nextjs";
import { SessionContextProvider } from "@supabase/auth-helpers-react";
import { appWithTranslation } from "next-i18next";
import type { AppProps } from "next/app";
import { useState } from "react";
import { Database } from "types/supabase";
import "../styles/globals.css";

function MyApp({ Component, pageProps }: AppProps) {
  const [supabase] = useState(() => createBrowserSupabaseClient<Database>());
  return (
    <SessionContextProvider supabaseClient={supabase}>
      <Component {...pageProps} />
    </SessionContextProvider>
  );
}

export default appWithTranslation(MyApp);
