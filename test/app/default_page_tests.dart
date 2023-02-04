import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_gen/gen_l10n/app_localizations_en.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";
import "package:meta/meta.dart";
import "package:portal/app/app.dart";
import "package:portal/app/app_module.dart";
import "package:portal/app/routing/destination.dart";
import "package:provider/provider.dart";

import "../go_router/navigation_helper.dart";
import "../test_app_widgets.dart";
import "../test_environment.dart";

@isTest
void defaultPageTests(
  DestinationWithoutParams destination,
  Key pageKey,
  String Function(AppLocalizations) pageLabel,
) {
  testAppWidgets(
    "Sets page title when used as initial location",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
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

  testAppWidgets(
    "Sets page title on navigation",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
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
