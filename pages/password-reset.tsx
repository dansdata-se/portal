import { useSession } from "@supabase/auth-helpers-react";
import LoginLayout from "components/Login/Layout";
import PasswordResetContentLayout from "components/Login/PasswordResetContentLayout";
import Nav from "navigation/Nav";
import type { GetServerSideProps, NextPage } from "next";
import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Head from "next/head";
import { useRouter } from "next/router";
import { useEffect } from "react";

const PasswordResetPage: NextPage = () => {
  const { t: tPage } = useTranslation("page-password-reset");

  const router = useRouter();
  const session = useSession();

  useEffect(() => {
    if (session !== null) {
      router.push(Nav().secure.Index.href);
    }
  }, [router, session]);

  return (
    <>
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>
      <LoginLayout currentDestination={Nav().PasswordReset}>
        <PasswordResetContentLayout tPage={tPage} />
      </LoginLayout>
    </>
  );
};

export const getServerSideProps: GetServerSideProps = async (context) => {
  return {
    props: {
      ...(await serverSideTranslations(context.locale as string, [
        "common",
        "login/common",
        "page-password-reset",
      ])),
    },
  };
};

export default PasswordResetPage;
