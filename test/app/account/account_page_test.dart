import "package:portal/app/account/account_page.dart";

import "../default_page_tests.dart";

void main() {
  defaultPageTests(
    const AccountDestination(),
    AccountPage.pageKey,
    (t) => t.labelAccount,
  );
}
