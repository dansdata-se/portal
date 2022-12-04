import { Destination } from "navigation/Nav";

function api(parents: Destination[]) {
  const Index: Destination = {
    href: "/secure/api/",
    label: (tCommon) => tCommon("label-secure-api"),
    parentDestinations: parents,
  };
  return {
    Index,
  };
}

export default api;
