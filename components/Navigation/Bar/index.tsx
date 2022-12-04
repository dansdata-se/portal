import classNames from "classnames";
import NextLink from "next/link";
import { ForwardedRef, forwardRef, HTMLAttributes, ReactNode } from "react";
import { useTranslation } from "react-i18next";
import { LinkEntry, NavigationEntry } from "..";

function NavigationBar({
  entries,
  ...attrs
}: {
  entries: NavigationEntry[];
} & HTMLAttributes<HTMLElement>) {
  return (
    <nav
      {...attrs}
      className={classNames(
        "flex",
        "bg-surface",
        "h-20",
        "w-full",
        "items-start",
        "before:block",
        "before:absolute",
        "before:inset-0",
        "before:bg-primary/elevation-tint-2",
        attrs.className
      )}
    >
      {entries.map(
        (entry) =>
          ({
            headline: null,
            option: (
              <NavigationBar.Link
                key={(entry as LinkEntry).destination.href}
                entry={entry as LinkEntry}
              />
            ),
            divider: null,
          }[entry.type])
      )}
    </nav>
  );
}

NavigationBar.Button = forwardRef(function Button(
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
        "relative",
        "w-full",
        "pt-3",
        "text-center",
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
          "inline-flex",
          "h-8",
          "w-16",
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

NavigationBar.Link = function Link({
  entry: { destination, icon, active },
}: {
  entry: LinkEntry;
}) {
  const { t: tCommon } = useTranslation("common");
  return (
    <NextLink href={destination.href}>
      <NavigationBar.Button
        icon={icon}
        text={destination.label(tCommon)}
        active={active}
      />
    </NextLink>
  );
};

export default NavigationBar;
