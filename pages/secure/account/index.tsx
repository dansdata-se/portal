import { useSupabaseClient } from "@supabase/auth-helpers-react";
import Button from "components/Button";
import Cookies from "js-cookie";
import Nav from "navigation/Nav";
import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Head from "next/head";
import { useRouter } from "next/router";
import { Database } from "types/supabase";

export default function Account() {
  const { t: tPage } = useTranslation("secure/account/page");

  const router = useRouter();
  const supabaseClient = useSupabaseClient<Database>();

  return (
    <div>
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>

      <main>
        <h1 className="typography-display-large">{tPage("page-title")}</h1>
        <Button
          variant="outlined"
          text={tPage("delete-account")}
          onClick={() => {
            supabaseClient.rpc("delete_account").then((r) => {
              /* Temporary (bad) workaround to kill current session: */

              if (r.error === null) {
                // JWT is still techincally valid.
                // Remove local cookie to prevent continued use of the site.
                Cookies.remove("supabase-auth-token");
                // Navigate user to the expected "signed out page"
                router.push(Nav().Index.href);
                // Force a page refresh to stop Next
                // from using a cached `useSession` state.
                window.location.reload();
              }
            });
          }}
        />
      </main>
    </div>
  );
}

export async function getStaticProps({ locale }: { locale: string }) {
  return {
    props: {
      ...(await serverSideTranslations(locale, [
        "common",
        "secure/account/page",
      ])),
    },
  };
}
