import "package:flutter_test/flutter_test.dart";
import "package:portal/app/routing/portal_scaffold.dart";
import "package:portal/app/routing/primary_navigation_entries.dart";

import "../../test_environment.dart";

void main() {
  test(
    "correlates exact paths with navigation entries correctly",
    () async {
      for (var e in PrimaryNavigationEntries.values) {
        expect(
          PortalScaffold.getSelectedDestinationIndex(e.destination.location),
          e.index,
        );
      }
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "correlates subpaths with navigation entries correctly",
    () async {
      for (var e in PrimaryNavigationEntries.values) {
        final fullPath = "${e.destination.location}/abc".replaceAll("//", "/");
        expect(
          PortalScaffold.getSelectedDestinationIndex(fullPath),
          e.index,
        );
      }
    },
    skip: !TestEnvironment.testSuite.smoke,
  );
}
