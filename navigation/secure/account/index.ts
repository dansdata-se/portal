import { Destination } from "navigation/Nav";

function account(parents: Destination[]) {
  const Index: Destination = {
    href: "/secure/account/",
    label: (tCommon) => tCommon("label-secure-account"),
    parentDestinations: parents,
  };
  return {
    Index,
  };
}

export default account;
