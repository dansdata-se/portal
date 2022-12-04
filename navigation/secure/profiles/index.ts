import { Destination } from "navigation/Nav";

function profiles(parents: Destination[]) {
  const Index: Destination = {
    href: "/secure/profiles/",
    label: (tCommon) => tCommon("label-secure-profiles"),
    parentDestinations: parents,
  };
  return {
    Index,
  };
}

export default profiles;
