import { getUser } from "@supabase/auth-helpers-nextjs";
import Button from "components/Button";
import Footer from "components/Footer";
import DarkModeSwitch from "components/Switch/DarkMode";
import TextField from "components/TextField";
import type { GetServerSideProps, NextPage } from "next";
import { useTranslation } from "next-i18next";
import { serverSideTranslations } from "next-i18next/serverSideTranslations";
import Image from "next/future/image";
import Head from "next/head";
import Link from "next/link";
import { useRouter } from "next/router";
import { useEffect, useState } from "react";
import { Eye, EyeOff } from "react-feather";
import { useMediaQuery } from "usehooks-ts";

const LogIn: NextPage = () => {
  const router = useRouter();
  const { t: tPage } = useTranslation("page-log-in");

  // Force small footer when image squishes the left-hand bar too much.
  const forceSmallFooter = useMediaQuery(
    "((min-width: 768px) and (max-width: 1150px)) or ((min-width: 1280px) and (max-width: 1700px))"
  );

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [passwordVisible, setPasswordVisible] = useState(false);
  const [emailError, setEmailError] = useState(false);
  const [passwordError, setPasswordError] = useState(false);

  useEffect(() => {
    setEmailError(false);
  }, [email]);
  useEffect(() => {
    setPasswordError(false);
  }, [password]);

  return (
    <>
      <Head>
        <title>{tPage("head-title")}</title>
      </Head>

      <div className="flex min-h-full flex-row items-stretch">
        <div className="relative flex min-h-full flex-col w-full md:w-1/2 xl:w-1/3">
          <header className="flex flex-row items-center justify-between w-full py-2 px-4">
            <div className="flex flex-row gap-3">
              <div className="relative overflow-hidden h-[var(--md-sys-typescale-headline-small-line-height)] aspect-square rounded-xs">
                <Image
                  priority={true}
                  className="object-cover"
                  src="/images/logo.webp"
                  alt=""
                  sizes="2rem" // var(--md-sys-typescale-headline-small-line-height)
                  fill
                />
              </div>
              <div className="typography-headline-small">
                <Link
                  href="https://dansdata.se"
                  locale={router.locale === "en" ? "sv" : "en"}
                >
                  Dansdata
                </Link>{" "}
                / <span className="text-primary">Portal</span>
              </div>
            </div>
            <DarkModeSwitch />
          </header>
          <div className="h-8 grow"></div>
          <main className="prose grow mx-auto px-4 w-full max-w-sm">
            <h1>{tPage("title-log-in")}</h1>
            <div className="flex flex-col gap-4 w-full max-w-sm">
              <TextField
                id="signin-email"
                className="w-full"
                variant="outlined"
                error={emailError}
                label={tPage("label-email")}
                type="email"
                value={email}
                onValueChange={setEmail}
              />
              <TextField
                id="signin-password"
                className="w-full"
                variant="outlined"
                error={passwordError}
                label={tPage("label-password")}
                type={passwordVisible ? "singlelineText" : "password"}
                trailing={
                  <button onClick={() => setPasswordVisible(!passwordVisible)}>
                    {passwordVisible ? <EyeOff /> : <Eye />}
                  </button>
                }
                value={password}
                onValueChange={setPassword}
              />
              <Button
                className="w-full"
                variant="filled"
                text={tPage("action-log-in")}
                onClick={() => {
                  setEmailError(email.length === 0);
                  setPasswordError(password.length === 0);
                }}
              />
            </div>
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
  const { user } = await getUser(context);
  if (user !== null) {
    let redirectTo = "/secure/";
    let { redirectedFrom } = context.query;
    if (Array.isArray(redirectedFrom)) {
      redirectTo = redirectedFrom[0];
    } else if (redirectedFrom) {
      redirectTo = redirectedFrom;
    }

    return {
      redirect: {
        destination: redirectTo,
        permanent: false,
      },
    };
  }

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
