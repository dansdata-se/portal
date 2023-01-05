import "package:flutter/widgets.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_test/flutter_test.dart";
import "package:google_fonts/google_fonts.dart";
import "package:portal/app/app_module.dart";
import "package:portal/widgets/dansdata_logo.dart";
import "package:provider/provider.dart";

import "../google_fonts/preload_fonts.dart";
import "../shared_preferences/mock_prefs.dart";
import "../test_environment.dart";

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets(
    "Displays title and tagline by default",
    (WidgetTester tester) async {
      final mockPrefs = MockPrefs({});
      final appModule = await AppModule.initialize(
        sharedPreferences: mockPrefs,
      );

      await preloadFonts(tester);

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

  testWidgets(
    "Can hide title",
    (WidgetTester tester) async {
      final mockPrefs = MockPrefs({});
      final appModule = await AppModule.initialize(
        sharedPreferences: mockPrefs,
      );

      await preloadFonts(tester);

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

  testWidgets(
    "Can hide tagline",
    (WidgetTester tester) async {
      final mockPrefs = MockPrefs({});
      final appModule = await AppModule.initialize(
        sharedPreferences: mockPrefs,
      );

      await preloadFonts(tester);

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
