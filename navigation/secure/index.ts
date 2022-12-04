import { Destination } from "navigation/Nav";
import account from "./account";
import api from "./api";
import events from "./events";
import profiles from "./profiles";

function secure(parents: Destination[]) {
  const Index: Destination = {
    href: "/secure/",
    label: (tCommon) => tCommon("label-secure-home"),
    parentDestinations: parents,
  };
  return {
    Index,
    account: account([...parents, Index]),
    api: api([...parents, Index]),
    events: events([...parents, Index]),
    profiles: profiles([...parents, Index]),
  };
}

export default secure;
