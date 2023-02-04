import "package:flutter/material.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";
import "package:flutter_test/flutter_test.dart";
import "package:portal/app/app_module.dart";
import "package:portal/app/routing/portal_navigation_drawer.dart";
import "package:portal/app/routing/primary_navigation_entries.dart";
import "package:portal/app/routing/rail_drawer_trailing.dart";
import "package:portal/widgets/dansdata_logo.dart";

import "../../device.dart";
import "../../test_app_widgets.dart";
import "../../test_environment.dart";

void main() async {
  testAppWidgets(
    "can be scrolled if content is overflowing height",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      await tester.simulateDevice(
        const Device(name: "500x150", width: 500, height: 150),
      );

      const containerKey = Key("parent");
      const drawerKey = Key("drawer");

      await tester.pumpWidget(
        wrapper(
          appModule: appModule,
          child: Scaffold(
            body: AdaptiveLayout(
              internalAnimations: false,
              primaryNavigation: SlotLayout(
                config: {
                  Breakpoints.smallAndUp: SlotLayout.from(
                    key: containerKey,
                    builder: (context) => PortalNavigationDrawer(
                      key: drawerKey,
                      selectedIndex: 0,
                      onDestinationSelected: (_, __) {},
                      destinations: PrimaryNavigationEntries.values,
                    ),
                  )
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Ensure content is overflowing container height
      expect(
        tester
            .getRect(find.byKey(containerKey))
            .overlaps(tester.getRect(find.bySubtype<DansdataLogo>())),
        true,
      );
      expect(
        tester
            .getRect(find.byKey(containerKey))
            .overlaps(tester.getRect(find.bySubtype<RailDrawerTrailing>())),
        false,
      );

      await tester.dragUntilVisible(
        find.bySubtype<RailDrawerTrailing>(),
        find.byKey(drawerKey),
        const Offset(0, -100),
      );

      // Ensure bottom content was scrolled into view
      expect(
        tester
            .getRect(find.byKey(containerKey))
            .overlaps(tester.getRect(find.bySubtype<DansdataLogo>())),
        false,
      );
      expect(
        tester
            .getRect(find.byKey(containerKey))
            .overlaps(tester.getRect(find.bySubtype<RailDrawerTrailing>())),
        true,
      );
    },
    skip: !TestEnvironment.testSuite.smoke,
  );
}
