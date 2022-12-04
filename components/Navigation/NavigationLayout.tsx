import classNames from "classnames";
import DarkModeSwitch from "components/Switch/DarkMode";
import Image from "next/future/image";
import { HTMLAttributes, ReactNode } from "react";
import { LogOut } from "react-feather";
import { useTranslation } from "react-i18next";
import { useIsClient, useMediaQuery } from "usehooks-ts";
import { NavigationEntry } from ".";
import NavigationBar from "./Bar";
import NavigationDrawer from "./Drawer";
import NavigationRail from "./Rail";

export default function NavigationLayout({
  entries,
  children,
  ...attrs
}: {
  entries: NavigationEntry[];
  children: ReactNode;
} & HTMLAttributes<HTMLDivElement>) {
  const { t: tCommon } = useTranslation("common");

  const isMobile = useMediaQuery("(max-width: 640px)");
  const isTablet = useMediaQuery(
    "((min-width: 641px) and (max-width: 1024px))"
  );
  const isDesktop = !isTablet && !isMobile;

  // Workaround - do not render any navigation during SSR - to avoid:
  // > Hydration failed because the initial UI
  // > does not match what was rendered on the server.
  const isClient = useIsClient();
  return isClient ? (
    isMobile ? (
      <div className="relative flex flex-col min-h-full">
        <header className="flex items-center bg-surface gap-6 h-16 px-4">
          <div className="flex w-full items-center gap-4">
            <div className="relative overflow-hidden h-8 aspect-square rounded-xs shrink-0">
              <Image
                priority={true}
                className="object-cover"
                src="/images/logo.webp"
                alt=""
                sizes="2rem"
                fill
              />
            </div>
            <span className="typography-title-large text-primary">
              Dansdata <span className="text-on-surface-variant">Portal</span>
            </span>
          </div>
          <DarkModeSwitch className="shrink-0" />
          <button className="h-12 w-12 text-on-surface-variant text-center">
            <LogOut className="inline-block h-6 w-6" />
            <span className="sr-only">{tCommon("log-out")}</span>
          </button>
        </header>
        <div
          {...attrs}
          className={classNames("relative", "grow", attrs.className)}
        >
          {children}
        </div>
        <NavigationBar
          className="sticky bottom-0 mt-auto"
          entries={entries}
        />
      </div>
    ) : (
      <div className="relative min-h-full grid grid-cols-[auto_1fr]">
        {isDesktop && <NavigationDrawer entries={entries} />}
        {isTablet && <NavigationRail entries={entries} />}
        <div
          {...attrs}
          className={classNames("relative", "min-h-full", attrs.className)}
        >
          {children}
        </div>
      </div>
    )
  ) : (
    <div
      {...attrs}
      className={classNames("relative", "min-h-full", attrs.className)}
    >
      {children}
    </div>
  );
}
