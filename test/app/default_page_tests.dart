import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_gen/gen_l10n/app_localizations_en.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/app.dart";
import "package:portal/app/app_module.dart";
import "package:portal/app/routing/destination.dart";
import "package:provider/provider.dart";

import "../go_router/navigation_helper.dart";
import "../google_fonts/preload_fonts.dart";
import "../shared_preferences/mock_prefs.dart";
import "../test_environment.dart";

void defaultPageTests(
  DestinationWithoutParams destination,
  Key pageKey,
  String Function(AppLocalizations) pageLabel,
) {
  testWidgets(
    "Sets page title when used as initial location",
    (WidgetTester tester) async {
      await preloadFonts(tester);

      final mockPrefs = MockPrefs({});
      final appModule = await AppModule.initialize(
        sharedPreferences: mockPrefs,
      );

      final testRouter = GoRouter(
        initialLocation: destination.location,
        routes: [
          destination.build(),
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

      expect(find.byKey(pageKey), findsOneWidget);
      expect(
        appModule.pageTitleState.value,
        contains(pageLabel(AppLocalizationsEn())),
      );
    },
    skip: !TestEnvironment.testSuite.unit,
  );

  testWidgets(
    "Sets page title on navigation",
    (WidgetTester tester) async {
      await preloadFonts(tester);

      final mockPrefs = MockPrefs({});
      final appModule = await AppModule.initialize(
        sharedPreferences: mockPrefs,
      );

      final testRouter = GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => const Text("Hello World"),
          ),
          destination.build(),
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

      expect(find.byKey(pageKey), findsNothing);

      navigateTestRouter(testRouter, destination.location);
      await tester.pumpAndSettle();

      expect(find.byKey(pageKey), findsOneWidget);
      expect(
        appModule.pageTitleState.value,
        contains(pageLabel(AppLocalizationsEn())),
      );
    },
    skip: !TestEnvironment.testSuite.unit,
  );
}
