import "package:portal/app/auth/create_account_page.dart";

import "../default_page_tests.dart";

void main() {
  defaultPageTests(
    const CreateAccountDestination(),
    CreateAccountPage.pageKey,
    (t) => t.labelCreateAccount,
  );
}
