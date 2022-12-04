import Button from "components/Button";
import Footer from "components/Footer";
import Header from "components/Header";
import Nav from "navigation/Nav";
import type { GetServerSideProps, NextPage } from "next";
import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Head from "next/head";
import Link from "next/link";
import { useRouter } from "next/router";

const Legal: NextPage = () => {
  const router = useRouter();
  const { t: tCommon } = useTranslation("common");
  const { t: tPage } = useTranslation("legal/legal");

  return (
    <>
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>

      <div className="flex min-h-full flex-col items-stretch">
        <Header currentDestination={Nav().legal.Index} />
        <main className="prose my-10 container bg-surface grow">
          <h1>{tPage("title-legal")}</h1>
          <div className="flex flex-row flex-wrap gap-4">
            <Link
              href={"/legal/terms-of-service"}
              locale={router.locale}
            >
              <Button
                className="w-full md:w-auto"
                variant="filled"
                text={tCommon("label-legal-terms-of-service")}
              />
            </Link>
            <Link
              href={"/legal/privacy"}
              locale={router.locale}
            >
              <Button
                className="w-full md:w-auto"
                variant="filled"
                text={tCommon("label-legal-privacy-policy")}
              />
            </Link>
          </div>
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
        "legal/legal",
      ])),
    },
  };
};

export default Legal;
