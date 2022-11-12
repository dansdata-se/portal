import { Destination } from "navigation/Nav";

function secure(parents: Destination[]) {
  const Home: Destination = {
    href: "/secure",
    breadcrumbText: (tCommon) => tCommon("breadcrumb-secure-home"),
    parentDestinations: parents,
  };
  return {
    Home,
  };
}

export default secure;
