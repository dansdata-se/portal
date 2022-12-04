import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Head from "next/head";

export default function Api() {
  const { t: tPage } = useTranslation("secure/api/page");

  return (
    <div>
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>

      <main>
        <h1 className="typography-display-large">{tPage("page-title")}</h1>
      </main>
    </div>
  );
}

export async function getStaticProps({ locale }: { locale: string }) {
  return {
    props: {
      ...(await serverSideTranslations(locale, ["common", "secure/api/page"])),
    },
  };
}
