import classNames from "classnames";
import LanguageButton from "components/Button/Language";
import Image from "next/future/image";
import Link from "next/link";
import { useRouter } from "next/router";
import { HTMLAttributes } from "react";
import { useTranslation } from "react-i18next";
import ReactMarkdown from "react-markdown";
import rehypeRaw from "rehype-raw";

/**
 * Default footer for dansdata
 */
function Footer({
  className,
  forceSmall = false,
  ...props
}: { forceSmall?: boolean } & HTMLAttributes<HTMLElement>) {
  const router = useRouter();
  const { t: tCommon } = useTranslation("common");

  return (
    <footer
      {...props}
      className={`bg-primary-container text-on-primary-container ${className}`}
    >
      <div className="container py-6">
        <div className="grid grid-cols-[auto_1fr] gap-y-8 gap-x-4 items-center">
          <div
            className={classNames(
              "grid",
              "grid-cols-[auto_1fr]",
              "items-center",
              "gap-4",
              "col-span-2",
              { "xs:col-span-1": !forceSmall }
            )}
          >
            <div className="relative overflow-hidden h-16 aspect-square rounded-md">
              <Image
                priority={true}
                className="object-cover"
                src="/images/logo.webp"
                alt=""
                sizes="4rem"
                fill
              />
            </div>
            <div className="flex flex-col">
              <span className="typography-title-large">Dansdata</span>
              <span className="typography-body-small">
                {tCommon("tagline")}
              </span>
            </div>
          </div>

          <div
            className={classNames(
              "col-span-2",
              "justify-self-center",
              "order-first",
              {
                "xs:col-span-1": !forceSmall,
                "xs:order-none": !forceSmall,
                "xs:justify-self-end": !forceSmall,
              }
            )}
          >
            <LanguageButton variant="text" />
          </div>

          <span className="flex flex-col gap-2 typography-body-small col-span-2">
            <ReactMarkdown rehypePlugins={[rehypeRaw]}>
              {tCommon("footer-text-md")}
            </ReactMarkdown>
          </span>
          <hr className="col-span-2" />
          <div className="flex flex-row flex-wrap gap-2 items-center justify-between col-span-2">
            <div className="flex flex-row gap-2">
              <Link
                href={"/legal/terms-of-service"}
                locale={router.locale}
              >
                <span className="typography-body-small underline cursor-pointer">
                  {tCommon("label-legal-terms-of-service")}
                </span>
              </Link>
              <Link
                href={"/legal/privacy"}
                locale={router.locale}
              >
                <span className="typography-body-small underline cursor-pointer">
                  {tCommon("label-legal-privacy-policy")}
                </span>
              </Link>
            </div>
            <a
              className="typography-label-small underline"
              href={`https://github.com/dansdata-se/portal/tree/${process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_SHA}`}
              target="_blank"
              rel="noopener noreferrer"
            >
              {process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_REF}:
              {process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_SHA?.substring(0, 7)}
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
}

export default Footer;
