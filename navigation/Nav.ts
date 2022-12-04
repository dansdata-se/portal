import { TFunction } from "next-i18next";
import legal from "./legal";
import secure from "./secure";

export type Destination = {
  href: string;
  label: (tCommon: TFunction) => string;
  parentDestinations: Destination[];
};

function Nav() {
  const Index: Destination = {
    href: "/",
    label: (tCommon) => tCommon("label-root"),
    parentDestinations: [],
  };
  const Login: Destination = {
    href: "/",
    label: (tCommon) => tCommon("label-log-in"),
    parentDestinations: [Index],
  };
  const CreateAccount: Destination = {
    href: "/create-account",
    label: (tCommon) => tCommon("label-create-account"),
    parentDestinations: [Index],
  };
  const PasswordReset: Destination = {
    href: "/password-reset",
    label: (tCommon) => tCommon("label-password-reset"),
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
