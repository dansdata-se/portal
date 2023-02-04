import "package:flutter/widgets.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_test/flutter_test.dart";
import "package:portal/app/app_module.dart";
import "package:portal/widgets/dansdata_logo.dart";
import "package:provider/provider.dart";

import "../test_app_widgets.dart";
import "../test_environment.dart";

void main() async {
  testAppWidgets(
    "Displays title and tagline by default",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: appModule.providers,
          child: Localizations(
            delegates: AppLocalizations.localizationsDelegates,
            locale: const Locale("en"),
            child: const DansdataLogo(),
          ),
        ),
      );
      expect(find.byKey(DansdataLogo.titleKey), findsOneWidget);
      expect(find.byKey(DansdataLogo.taglineKey), findsOneWidget);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  testAppWidgets(
    "Can hide title",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: appModule.providers,
          child: Localizations(
            delegates: AppLocalizations.localizationsDelegates,
            locale: const Locale("en"),
            child: const DansdataLogo(
              titleStyle: null,
            ),
          ),
        ),
      );
      expect(find.byKey(DansdataLogo.titleKey), findsNothing);
      expect(find.byKey(DansdataLogo.taglineKey), findsOneWidget);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  testAppWidgets(
    "Can hide tagline",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: appModule.providers,
          child: Localizations(
            delegates: AppLocalizations.localizationsDelegates,
            locale: const Locale("en"),
            child: const DansdataLogo(
              taglineStyle: null,
            ),
          ),
        ),
      );
      expect(find.byKey(DansdataLogo.titleKey), findsOneWidget);
      expect(find.byKey(DansdataLogo.taglineKey), findsNothing);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );
}
