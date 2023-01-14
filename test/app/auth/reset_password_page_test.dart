import "package:portal/app/auth/reset_password_page.dart";

import "../default_page_tests.dart";

void main() {
  defaultPageTests(
    const ResetPasswordDestination(),
    ResetPasswordPage.pageKey,
    (t) => t.labelResetPassword,
  );
}
