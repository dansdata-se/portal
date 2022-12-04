import Nav, { Destination } from "navigation/Nav";
import { ReactNode } from "react";
import { Calendar, Code, Home as HomeIcon, Key, Users } from "react-feather";

export type EntryType = "headline" | "option" | "divider";

export interface BaseEntry {
  readonly type: EntryType;
}

export class HeadlineEntry implements BaseEntry {
  public readonly type: EntryType = "headline";
  constructor(public readonly text: string) {}
}

export class LinkEntry implements BaseEntry {
  public readonly type: EntryType = "option";
  public readonly active: boolean;
  public readonly badgeLabelText: string;
  constructor(
    public readonly destination: Destination,
    public readonly icon: ReactNode,
    options?: {
      active?: (destination: Destination) => boolean;
      badgeLabelText?: string;
    }
  ) {
    this.active = options?.active?.(destination) ?? false;
    this.badgeLabelText = options?.badgeLabelText ?? "";
  }
}

export class DividerEntry implements BaseEntry {
  public readonly type: EntryType = "divider";
}

export type NavigationEntry = HeadlineEntry | LinkEntry | DividerEntry;

export function getDefaultNavigationEntries(
  currentDestination: Destination
): NavigationEntry[] {
  const nav = Nav();
  return [
    new LinkEntry(nav.secure.Index, <HomeIcon />, {
      active: (d) => d.href === currentDestination.href,
    }),
    new LinkEntry(nav.secure.events.Index, <Calendar />, {
      active: (d) => d.href === currentDestination.href,
    }),
    new LinkEntry(nav.secure.profiles.Index, <Users />, {
      active: (d) => d.href === currentDestination.href,
    }),
    new LinkEntry(nav.secure.api.Index, <Code />, {
      active: (d) => d.href === currentDestination.href,
    }),
    new LinkEntry(nav.secure.account.Index, <Key />, {
      active: (d) => d.href === currentDestination.href,
    }),
  ];
}
