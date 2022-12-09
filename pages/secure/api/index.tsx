import Footer from "components/Footer";
import { getDefaultNavigationEntries } from "components/Navigation";
import NavigationLayout from "components/Navigation/NavigationLayout";
import Nav from "navigation/Nav";
import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Head from "next/head";
import { useMemo } from "react";

export default function Api() {
  const { t: tPage } = useTranslation("secure/api/page");

  const navigationEntries = useMemo(
    () => getDefaultNavigationEntries(Nav().secure.api.Index),
    []
  );

  return (
    <NavigationLayout
      className="flex flex-col"
      entries={navigationEntries}
    >
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>
      <main className="grow">
        <h1 className="typography-display-large">{tPage("page-title")}</h1>
      </main>
      <Footer />
    </NavigationLayout>
  );
}

export async function getStaticProps({ locale }: { locale: string }) {
  return {
    props: {
      ...(await serverSideTranslations(locale, ["common", "secure/api/page"])),
    },
  };
}