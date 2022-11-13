import { Destination } from "navigation/Nav";

function secure(parents: Destination[]) {
  const Index: Destination = {
    href: "/secure/",
    breadcrumbText: (tCommon) => tCommon("breadcrumb-secure-home"),
    parentDestinations: parents,
  };
  return {
    Index,
  };
}

export default secure;
