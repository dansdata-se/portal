import "package:portal/app/profiles/profiles_page.dart";

import "../default_page_tests.dart";

void main() {
  defaultPageTests(
    const ProfilesDestination(),
    ProfilesPage.pageKey,
    (t) => t.labelProfiles,
  );
}
