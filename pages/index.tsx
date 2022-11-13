import Button from "components/Button";
import Footer from "components/Footer";
import Header from "components/Header";
import TextField from "components/TextField";
import Nav from "navigation/Nav";
import type { GetServerSideProps, NextPage } from "next";
import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Image from "next/future/image";
import Head from "next/head";
import { useRef, useState } from "react";
import { Eye, EyeOff } from "react-feather";
import { useMediaQuery } from "usehooks-ts";

const LogIn: NextPage = () => {
  const { t: tPage } = useTranslation("page-log-in");

  // Force small footer when image squishes the left-hand bar too much.
  const forceSmallFooter = useMediaQuery(
    "((min-width: 768px) and (max-width: 1150px)) or ((min-width: 1280px) and (max-width: 1700px))"
  );

  const emailRef = useRef<HTMLInputElement>(null);
  const passwordRef = useRef<HTMLInputElement>(null);
  const [passwordVisible, setPasswordVisible] = useState(false);

  return (
    <>
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>

      <div className="flex min-h-full flex-row items-stretch">
        <div className="relative flex min-h-full flex-col w-full md:w-1/2 xl:w-1/3">
          <Header currentDestination={Nav().Login} />
          <div className="h-8 grow"></div>
          <main className="prose grow mx-auto px-4 w-full max-w-sm">
            <h1>{tPage("title-log-in")}</h1>
            <form
              className="flex flex-col gap-4 w-full max-w-sm"
              noValidate
              onSubmit={(e) => {
                e.preventDefault();
                emailRef.current?.checkValidity();
                passwordRef.current?.checkValidity();
              }}
            >
              <TextField
                ref={emailRef}
                id="signin-email"
                className="w-full"
                variant="outlined"
                label={tPage("label-email")}
                type="email"
                required
              />
              <TextField
                ref={passwordRef}
                id="signin-password"
                className="w-full"
                variant="outlined"
                label={tPage("label-password")}
                type={passwordVisible ? "singlelineText" : "password"}
                trailing={
                  <button onClick={() => setPasswordVisible(!passwordVisible)}>
                    {passwordVisible ? <EyeOff /> : <Eye />}
                  </button>
                }
                required
              />
              <Button
                className="w-full"
                variant="filled"
                text={tPage("action-log-in")}
                type="submit"
              />
            </form>
          </main>
          <div className="h-8 grow"></div>
          <Footer forceSmall={forceSmallFooter} />
        </div>
        <div className="relative overflow-hidden flex-grow hidden md:block">
          <Image
            priority={true}
            className="object-cover"
            src="/images/dansbana.webp"
            alt=""
            fill
          />
        </div>
      </div>
    </>
  );
};

export const getServerSideProps: GetServerSideProps = async (context) => {
  return {
    props: {
      ...(await serverSideTranslations(context.locale as string, [
        "common",
        "page-log-in",
      ])),
    },
  };
};

export default LogIn;
