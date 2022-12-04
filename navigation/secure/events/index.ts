import { Destination } from "navigation/Nav";

function events(parents: Destination[]) {
  const Index: Destination = {
    href: "/secure/events/",
    label: (tCommon) => tCommon("label-secure-events"),
    parentDestinations: parents,
  };
  return {
    Index,
  };
}

export default events;
