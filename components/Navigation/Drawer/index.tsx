import { useSupabaseClient } from "@supabase/auth-helpers-react";
import classNames from "classnames";
import LanguageButton from "components/Button/Language";
import DarkModeSwitch from "components/Switch/DarkMode";
import Nav from "navigation/Nav";
import Image from "next/future/image";
import NextLink from "next/link";
import { useRouter } from "next/router";
import { ForwardedRef, forwardRef, HTMLAttributes, ReactNode } from "react";
import { LogOut } from "react-feather";
import { useTranslation } from "react-i18next";
import { Database } from "types/supabase";
import { DividerEntry, HeadlineEntry, LinkEntry, NavigationEntry } from "..";

function NavigationDrawer({
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
        "flex flex-col bg-surface h-full max-w-full w-[22.5rem] rounded-r-lg",
        attrs.className
      )}
    >
      <header
        className={classNames(
          "grid",
          "grid-cols-[auto_1fr]",
          "items-center",
          "gap-4",
          "mx-7",
          "my-7"
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
          <span className="typography-headline-large text-primary">
            Dansdata <span className="text-on-surface-variant">Portal</span>
          </span>
          <span className="typography-body-small">{tCommon("tagline")}</span>
        </div>
      </header>
      <div className="flex flex-col items-stretch gap-0">
        {entries.map(
          (entry, i) =>
            ({
              headline: (
                <NavigationDrawer.Headline
                  key={(entry as HeadlineEntry).text}
                  entry={entry as HeadlineEntry}
                />
              ),
              option: (
                <NavigationDrawer.Link
                  key={(entry as LinkEntry).destination.href}
                  entry={entry as LinkEntry}
                />
              ),
              divider: (
                <NavigationDrawer.Divider
                  key={i}
                  entry={entry as DividerEntry}
                />
              ),
            }[entry.type])
        )}
      </div>
      <footer className="mt-auto flex flex-col items-stretch my-3 gap-3">
        <NavigationDrawer.Button
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
        <div className="mx-7 flex items-center justify-between">
          <DarkModeSwitch />
          <LanguageButton variant="text" />
        </div>
      </footer>
    </nav>
  );
}

NavigationDrawer.Headline = function Headline({
  entry,
}: {
  entry: HeadlineEntry;
}) {
  return <h2 className="typography-title-small mx-7">{entry.text}</h2>;
};

NavigationDrawer.Button = forwardRef(function Button(
  {
    text,
    icon,
    badgeLabelText,
    active = false,
    onClick = () => {},
  }: {
    text: string;
    icon: ReactNode;
    badgeLabelText?: string;
    active?: boolean;
    onClick?: () => void;
  },
  ref: ForwardedRef<HTMLButtonElement>
) {
  return (
    <button
      ref={ref}
      className={classNames(
        "relative",
        "grid",
        "grid-cols-[1.5rem_1fr_auto]",
        "gap-3",
        "items-center",
        "text-left",
        "min-h-[3.5rem]",
        "pl-4",
        "pr-6",
        "mx-3",
        "rounded-xl",
        "overflow-hidden",
        "before:absolute",
        "before:block",
        "before:inset-0",
        "focus:outline-none",
        {
          "bg-secondary-container": active,
          "text-on-secondary-container": active,
          "text-on-surface-variant": !active,
          "hover:text-on-surface": !active,
          "hover:before:bg-on-secondary-container/hover": active,
          "hover:before:bg-on-surface/hover": !active,
          "focus-visible:before:bg-on-secondary-container/focus": active,
          "focus-visible:before:bg-on-surface/focus": !active,
          "active:before:bg-on-secondary-container/pressed": active,
          "active:before:bg-on-surface/pressed": !active,
        }
      )}
      onClick={onClick}
    >
      <div>{icon}</div>
      <div>{text}</div>
      <div className="typography-label-large text-on-surface-variant">
        {badgeLabelText}
      </div>
    </button>
  );
});

NavigationDrawer.Link = function Link({
  entry: { destination, icon, badgeLabelText, active },
}: {
  entry: LinkEntry;
}) {
  const { t: tCommon } = useTranslation("common");
  return (
    <NextLink href={destination.href}>
      <NavigationDrawer.Button
        icon={icon}
        text={destination.label(tCommon)}
        badgeLabelText={badgeLabelText}
        active={active}
      />
    </NextLink>
  );
};

NavigationDrawer.Divider = function Divider(_: { entry: DividerEntry }) {
  return <hr className="mx-7 my-4" />;
};

export default NavigationDrawer;
