import { useSupabaseClient } from "@supabase/auth-helpers-react";
import classNames from "classnames";
import DarkModeSwitch from "components/Switch/DarkMode";
import Nav from "navigation/Nav";
import Image from "next/future/image";
import NextLink from "next/link";
import { useRouter } from "next/router";
import { ForwardedRef, forwardRef, HTMLAttributes, ReactNode } from "react";
import { LogOut } from "react-feather";
import { useTranslation } from "react-i18next";
import { Database } from "types/supabase";
import { LinkEntry, NavigationEntry } from "..";

function NavigationRail({
  entries,
  ...attrs
}: {
  entries: NavigationEntry[];
} & HTMLAttributes<HTMLElement>) {
  const { t: tCommon } = useTranslation("common");
  const router = useRouter();
  const supabaseClient = useSupabaseClient<Database>();
  return (
    <nav
      {...attrs}
      className={classNames(
        "flex flex-col bg-surface h-full max-w-full w-20",
        attrs.className
      )}
    >
      <header className="relative overflow-hidden w-fill aspect-square rounded-md mx-3 my-7">
        <Image
          priority={true}
          className="object-cover"
          src="/images/logo.webp"
          alt=""
          sizes="3.5rem"
          fill
        />
      </header>
      <div className="flex flex-col items-center gap-3">
        {entries.map(
          (entry) =>
            ({
              headline: null,
              option: (
                <NavigationRail.Link
                  key={(entry as LinkEntry).destination.href}
                  entry={entry as LinkEntry}
                />
              ),
              divider: null,
            }[entry.type])
        )}
      </div>
      <footer className="mt-auto flex flex-col items-center my-3 gap-3">
        <DarkModeSwitch />
        <NavigationRail.Button
          icon={<LogOut />}
          text={tCommon("log-out")}
          onClick={() => {
            supabaseClient.auth
              .signOut()
              .catch(console.error)
              .then(() => {
                router.push(Nav().Index.href);
              });
          }}
        />
      </footer>
    </nav>
  );
}

NavigationRail.Button = forwardRef(function Button(
  {
    text,
    icon,
    active = false,
    onClick = () => {},
  }: {
    text: string;
    icon: ReactNode;
    active?: boolean;
    onClick?: () => void;
  },
  ref: ForwardedRef<HTMLButtonElement>
) {
  return (
    <button
      ref={ref}
      className={classNames(
        "group",
        "w-full",
        "relative",
        "text-center",
        "px-3",
        "before:block",
        "before:absolute",
        "before:inset-0",
        "focus:outline-none"
      )}
      onClick={onClick}
    >
      <div
        className={classNames(
          "relative",
          "flex",
          "h-8",
          "w-full",
          "py-1",
          "mb-1",
          "overflow-hidden",
          "rounded-lg",
          "justify-center",
          "before:absolute",
          "before:block",
          "before:inset-0",
          {
            "bg-secondary-container": active,
            "text-on-secondary-container": active,
            "text-on-surface-variant": !active,
            "group-hover:before:bg-on-surface/hover": active,
            "group-hover:before:bg-on-surface-variant/hover": !active,
            "group-focus-visible:before:bg-on-surface/focus": active,
            "group-focus-visible:before:bg-on-surface-variant/focus": !active,
            "group-active:before:bg-on-surface/pressed": active,
            "group-active:before:bg-on-surface-variant/pressed": !active,
          }
        )}
      >
        {icon}
      </div>
      <div
        className={classNames("typography-label-medium", {
          "text-on-surface": active,
          "text-on-surface-variant": !active,
        })}
      >
        {text}
      </div>
    </button>
  );
});

NavigationRail.Link = function Link({
  entry: { destination, icon, active },
}: {
  entry: LinkEntry;
}) {
  const { t: tCommon } = useTranslation("common");
  return (
    <NextLink href={destination.href}>
      <NavigationRail.Button
        icon={icon}
        text={destination.label(tCommon)}
        active={active}
      />
    </NextLink>
  );
};

export default NavigationRail;
