import { Destination } from "navigation/Nav";

function legal(parents: Destination[]) {
  const Legal: Destination = {
    href: "/legal/",
    label: (tCommon) => tCommon("label-legal-root"),
    parentDestinations: parents,
  };
  const TermsOfService: Destination = {
    href: "/legal/terms-of-service",
    label: (tCommon) => tCommon("label-legal-terms-of-service"),
    parentDestinations: [...parents, Legal],
  };
  const Privacy: Destination = {
    href: "/legal/privacy",
    label: (tCommon) => tCommon("label-legal-privacy-policy"),
    parentDestinations: [...parents, Legal],
  };
  return {
    Index: Legal,
    TermsOfService,
    Privacy,
  };
}

export default legal;
