import { Destination } from "navigation/Nav";

function secure(parents: Destination[]) {
  const Index: Destination = {
    href: "/secure/",
    label: (tCommon) => tCommon("label-secure-home"),
    parentDestinations: parents,
  };
  return {
    Index,
  };
}

export default secure;
