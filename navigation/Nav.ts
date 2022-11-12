import { TFunction } from "next-i18next";
import secure from "./secure";

export type Destination = {
  href: string;
  breadcrumbText: (tCommon: TFunction) => string;
  parentDestinations: Destination[];
};

function Nav() {
  const Index: Destination = {
    href: "/",
    breadcrumbText: (tCommon) => tCommon("breadcrumb-root"),
    parentDestinations: [],
  };
  const Login: Destination = {
    href: "/",
    breadcrumbText: (tCommon) => tCommon("breadcrumb-log-in"),
    parentDestinations: [Index],
  };
  return {
    secure: secure([Index]),
    Index,
    Login,
  };
}

export default Nav;
