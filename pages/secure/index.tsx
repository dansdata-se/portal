import LanguageButton from "components/Button/Language";
import type { NextPage } from "next";
import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Head from "next/head";
import { useRouter } from "next/router";

const Home: NextPage = () => {
  const router = useRouter();
  const { t: tPage } = useTranslation("page-home");
  return (
    <div>
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>

      <main>
        <h1>Protected Area</h1>
        <LanguageButton variant={"text"} />
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
