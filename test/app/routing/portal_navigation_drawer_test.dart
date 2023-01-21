import "package:flutter/material.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";
import "package:flutter_test/flutter_test.dart";
import "package:google_fonts/google_fonts.dart";
import "package:portal/app/app_module.dart";
import "package:portal/app/routing/portal_navigation_drawer.dart";
import "package:portal/app/routing/primary_navigation_entries.dart";
import "package:portal/app/routing/rail_drawer_trailing.dart";
import "package:portal/widgets/dansdata_logo.dart";

import "../../google_fonts/preload_fonts.dart";
import "../../shared_preferences/mock_prefs.dart";
import "../../test_environment.dart";
import "../widget_test_scaffold.dart";

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets(
    "can be scrolled if content is overflowing height",
    (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(500, 150);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final appModule = await AppModule.initialize(
        sharedPreferences: MockPrefs({}),
      );

      await preloadFonts(tester);

      const containerKey = Key("parent");
      const drawerKey = Key("drawer");

      await tester.pumpWidget(
        AppWidgetTestScaffold(
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
