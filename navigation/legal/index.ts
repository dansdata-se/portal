import { Destination } from "navigation/Nav";

function legal(parents: Destination[]) {
  const Legal: Destination = {
    href: "/legal/",
    breadcrumbText: (tCommon) => tCommon("breadcrumb-legal-root"),
    parentDestinations: parents,
  };
  const TermsOfService: Destination = {
    href: "/legal/terms-of-service",
    breadcrumbText: (tCommon) => tCommon("breadcrumb-legal-terms-of-service"),
    parentDestinations: [...parents, Legal],
  };
  const Privacy: Destination = {
    href: "/legal/privacy",
    breadcrumbText: (tCommon) => tCommon("breadcrumb-legal-privacy-policy"),
    parentDestinations: [...parents, Legal],
  };
  return {
    Index: Legal,
    TermsOfService,
    Privacy,
  };
}

export default legal;
