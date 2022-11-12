import Button from "components/Button";
import LanguageButton from "components/Button/Language";
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

const SignIn: NextPage = () => {
  const router = useRouter();
  const { t: tCommon } = useTranslation("common");
  const { t: tPage } = useTranslation("page-sign-in");

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
        <div className="relative w-full md:w-1/2 xl:w-1/3">
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
          <main className="prose my-40 container">
            <h1>{tCommon("Sign In")}</h1>
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
                text={tPage("action-sign-in")}
                onClick={() => {
                  setEmailError(email.length === 0);
                  setPasswordError(password.length === 0);
                }}
              />
            </div>
          </main>
          <footer className="absolute bottom-0 flex flex-row items-center justify-between w-full py-2 px-4">
            <LanguageButton variant="text" />
            <a
              href={`https://github.com/dansdata-se/portal/tree/${process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_SHA}`}
              target="_blank"
              rel="noopener noreferrer"
            >
              <span className="block typography-label-small -mb-2">
                Version
              </span>
              <span className="typography-label-small text-primary">
                {process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_REF}:
                {process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_SHA?.substring(0, 7)}
              </span>
            </a>
          </footer>
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
        "page-sign-in",
      ])),
    },
  };
};

export default SignIn;
