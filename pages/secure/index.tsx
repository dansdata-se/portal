import { useSupabaseClient } from "@supabase/auth-helpers-react";
import Button from "components/Button";
import LanguageButton from "components/Button/Language";
import Cookies from "js-cookie";
import Nav from "navigation/Nav";
import type { NextPage } from "next";
import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Head from "next/head";
import { useRouter } from "next/router";
import { Database } from "types/supabase";

const Home: NextPage = () => {
  const router = useRouter();
  const { t: tPage } = useTranslation("page-home");
  const supabaseClient = useSupabaseClient<Database>();
  return (
    <div>
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>

      <main>
        <h1>Protected Area</h1>
        <LanguageButton variant={"text"} />
        <Button
          variant="outlined"
          text="Logout"
          onClick={() => {
            supabaseClient.auth
              .signOut()
              .catch(console.error)
              .then(() => {
                router.push(Nav().Index.href);
              });
          }}
        />
        <Button
          variant="outlined"
          text="Delete Account"
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
};

export async function getStaticProps({ locale }: { locale: string }) {
  return {
    props: {
      ...(await serverSideTranslations(locale, ["common", "page-home"])),
    },
  };
}

export default Home;
