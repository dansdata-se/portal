import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/app.dart";
import "package:portal/app/app_module.dart";
import "package:provider/provider.dart";

import "../go_router/navigation_helper.dart";
import "../test_app_widgets.dart";
import "../test_environment.dart";

void main() {
  testAppWidgets(
    "Test app can navigate between routes",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      final testRouter = GoRouter(
        initialLocation: "/a",
        routes: [
          GoRoute(
            path: "/a",
            builder: (context, state) => const Text("Route A"),
          ),
          GoRoute(
            path: "/b",
            builder: (context, state) => const Text("Route B"),
          ),
        ],
      );

      await tester.pumpWidget(
        MultiProvider(
          providers: appModule.providers,
          child: Localizations(
            delegates: AppLocalizations.localizationsDelegates,
            locale: const Locale("en"),
            child: DansdataPortalApp(routerConfig: testRouter),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("Route A"), findsOneWidget);
      expect(find.text("Route B"), findsNothing);

      navigateTestRouter(testRouter, "/b");
      await tester.pumpAndSettle();

      expect(find.text("Route A"), findsNothing);
      expect(find.text("Route B"), findsOneWidget);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );
}
