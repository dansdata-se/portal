import LanguageButton from "components/Button/Language";
import Footer from "components/Footer";
import Header from "components/Header";
import Nav from "navigation/Nav";
import type { GetServerSideProps, NextPage } from "next";
import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Head from "next/head";
import { useRouter } from "next/router";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";

const PrivacyPolicy: NextPage = () => {
  const router = useRouter();
  const { t: tPage } = useTranslation("legal/privacy");

  return (
    <>
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>

      <div className="flex min-h-full flex-col items-stretch">
        <Header currentDestination={Nav().legal.Privacy} />
        <main className="prose my-10 container bg-surface grow">
          <ReactMarkdown remarkPlugins={[remarkGfm]}>
            {tPage("policy-md")}
          </ReactMarkdown>
          {router.locale !== "sv" && <LanguageButton variant="tonal" />}
        </main>
        <Footer />
      </div>
    </>
  );
};

export const getServerSideProps: GetServerSideProps = async (context) => {
  return {
    props: {
      ...(await serverSideTranslations(context.locale as string, [
        "common",
        "legal/privacy",
      ])),
    },
  };
};

export default PrivacyPolicy;
