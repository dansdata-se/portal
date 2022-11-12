import { Destination } from "navigation/Nav";
import Image from "next/future/image";
import Link from "next/link";
import { useRouter } from "next/router";
import { Fragment, HTMLAttributes } from "react";
import { useTranslation } from "react-i18next";

/**
 * A breadcrumb component for the header, including the Dansdata logo.
 */
function HeaderBreadcrumbs({
  currentDestination,
  ...props
}: {
  currentDestination: Destination;
} & HTMLAttributes<HTMLDivElement>) {
  const router = useRouter();
  const { t: tCommon } = useTranslation("common");

  return (
    <div
      {...props}
      className={`flex flex-row gap-3 ${props.className}`}
    >
      <Link
        href="/"
        locale={router.locale}
      >
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
      </Link>
      <div className="typography-headline-small">
        {currentDestination.parentDestinations.map((p) => (
          <Fragment key={p.href}>
            <Link
              href={p.href}
              locale={router.locale}
            >
              <span className="text-primary cursor-pointer">
                {p.breadcrumbText(tCommon)}
              </span>
            </Link>{" "}
            <span className="text-outline">/</span>{" "}
          </Fragment>
        ))}
        <span>{currentDestination.breadcrumbText(tCommon)}</span>
      </div>
    </div>
  );
}

export default HeaderBreadcrumbs;
