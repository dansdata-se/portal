import "package:portal/app/auth/login_page.dart";

import "../default_page_tests.dart";

void main() {
  defaultPageTests(
    const LoginDestination(),
    LoginPage.pageKey,
    (t) => t.labelLogin,
  );
}
