import { TFunction } from "next-i18next";
import legal from "./legal";
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
  const CreateAccount: Destination = {
    href: "/create-account",
    breadcrumbText: (tCommon) => tCommon("breadcrumb-create-account"),
    parentDestinations: [Index],
  };
  const PasswordReset: Destination = {
    href: "/password-reset",
    breadcrumbText: (tCommon) => tCommon("breadcrumb-password-reset"),
    parentDestinations: [Index],
  };
  return {
    legal: legal([Index]),
    secure: secure([Index]),
    Index,
    Login,
    CreateAccount,
    PasswordReset,
  };
}

export default Nav;
