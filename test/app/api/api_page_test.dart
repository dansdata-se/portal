import "package:portal/app/api/api_page.dart";

import "../default_page_tests.dart";

void main() {
  defaultPageTests(
    const ApiDestination(),
    ApiPage.pageKey,
    (t) => t.labelApi,
  );
}
