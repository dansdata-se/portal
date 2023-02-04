import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:portal/app/app_module.dart";
import "package:portal/app/auth/layout/auth_layout.dart";
import "package:portal/app/auth/layout/large_layout.dart";
import "package:portal/app/auth/layout/small_layout.dart";
import "package:portal/app/routing/portal_app_bar.dart";

import "../../../test_app_widgets.dart";
import "../../../test_environment.dart";

void main() {
  testAppWidgets(
    "switches layout and buttons when screen is resized down",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

      await tester.pumpWidget(
        wrapper(
          appModule: appModule,
          child: Builder(
            builder: (context) => AuthLayout(child: Container()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify initial layout
      expect(find.bySubtype<LargeLayout>(), findsOneWidget);
      expect(find.bySubtype<SmallLayout>(), findsNothing);

      // Verify FABs visible
      expect(find.byKey(LargeLayout.themeModeToggleKey), findsOneWidget);
      expect(find.byKey(LargeLayout.languageToggleKey), findsOneWidget);

      // Verify app bar not present
      expect(find.bySubtype<PortalAppBar>(), findsNothing);
      expect(find.byKey(PortalAppBar.themeModeToggleKey), findsNothing);
      expect(find.byKey(PortalAppBar.languageToggleKey), findsNothing);

      tester.binding.window.physicalSizeTestValue = const Size(320, 840);
      await tester.pumpAndSettle();

      // Verify layout switch
      expect(find.bySubtype<LargeLayout>(), findsNothing);
      expect(find.bySubtype<SmallLayout>(), findsOneWidget);

      // Verify FABs removed
      expect(find.byKey(LargeLayout.themeModeToggleKey), findsNothing);
      expect(find.byKey(LargeLayout.languageToggleKey), findsNothing);

      // Verify app bar added
      expect(find.bySubtype<PortalAppBar>(), findsOneWidget);
      expect(find.byKey(PortalAppBar.themeModeToggleKey), findsOneWidget);
      expect(find.byKey(PortalAppBar.languageToggleKey), findsOneWidget);
    },
    skip: !TestEnvironment.testSuite.unit,
  );

  testAppWidgets(
    "switches layout and buttons when screen is resized up",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(320, 840);

      await tester.pumpWidget(
        wrapper(
          appModule: appModule,
          child: Builder(
            builder: (context) => AuthLayout(child: Container()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify initial layout
      expect(find.bySubtype<LargeLayout>(), findsNothing);
      expect(find.bySubtype<SmallLayout>(), findsOneWidget);

      // Verify FABs not present
      expect(find.byKey(LargeLayout.themeModeToggleKey), findsNothing);
      expect(find.byKey(LargeLayout.languageToggleKey), findsNothing);

      // Verify app bar present
      expect(find.bySubtype<PortalAppBar>(), findsOneWidget);
      expect(find.byKey(PortalAppBar.themeModeToggleKey), findsOneWidget);
      expect(find.byKey(PortalAppBar.languageToggleKey), findsOneWidget);

      tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
      await tester.pumpAndSettle();

      // Verify layout switch
      expect(find.bySubtype<LargeLayout>(), findsOneWidget);
      expect(find.bySubtype<SmallLayout>(), findsNothing);

      // Verify FABs added
      expect(find.byKey(LargeLayout.themeModeToggleKey), findsOneWidget);
      expect(find.byKey(LargeLayout.languageToggleKey), findsOneWidget);

      // Verify app bar removed
      expect(find.bySubtype<PortalAppBar>(), findsNothing);
      expect(find.byKey(PortalAppBar.themeModeToggleKey), findsNothing);
      expect(find.byKey(PortalAppBar.languageToggleKey), findsNothing);
    },
    skip: !TestEnvironment.testSuite.unit,
  );
}
