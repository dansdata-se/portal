import "package:flutter/widgets.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_test/flutter_test.dart";
import "package:google_fonts/google_fonts.dart";
import "package:portal/app/splash/splash_fader.dart";
import "package:portal/app/splash/splash_module.dart";
import "package:portal/widgets/dansdata_logo.dart";
import "package:provider/provider.dart";

import "../../google_fonts/preload_fonts.dart";
import "../../shared_preferences/mock_prefs.dart";
import "../../test_environment.dart";

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets(
    "Displays splash screen when no child is given",
    (WidgetTester tester) async {
      final mockPrefs = MockPrefs({});
      final splashModule = await SplashModule.initialize(
        sharedPreferences: mockPrefs,
      );

      await preloadFonts(tester);

      await tester.pumpWidget(
        MultiProvider(
          providers: splashModule.providers,
          child: Localizations(
            delegates: AppLocalizations.localizationsDelegates,
            locale: const Locale("en"),
            child: const SplashFader(),
          ),
        ),
      );
      expect(find.byKey(SplashFader.splashKey), findsOneWidget);
      expect(find.byKey(SplashFader.childKey), findsNothing);
      expect(find.byKey(DansdataLogo.titleKey), findsOneWidget);
      expect(find.byKey(DansdataLogo.taglineKey), findsOneWidget);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  testWidgets(
    "Displays child if given",
    (WidgetTester tester) async {
      final mockPrefs = MockPrefs({});
      final splashModule = await SplashModule.initialize(
        sharedPreferences: mockPrefs,
      );

      await preloadFonts(tester);

      await tester.pumpWidget(
        MultiProvider(
          providers: splashModule.providers,
          child: Localizations(
            delegates: AppLocalizations.localizationsDelegates,
            locale: const Locale("en"),
            child: const SplashFader(
              child: Text("Hello World", key: SplashFader.childKey),
            ),
          ),
        ),
      );
      expect(find.byKey(SplashFader.splashKey), findsNothing);
      expect(find.byKey(SplashFader.childKey), findsOneWidget);
      expect(find.byKey(DansdataLogo.titleKey), findsNothing);
      expect(find.byKey(DansdataLogo.taglineKey), findsNothing);
      expect(find.text("Hello World"), findsOneWidget);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  testWidgets(
    "Can transition to child",
    (WidgetTester tester) async {
      final mockPrefs = MockPrefs({});
      final splashModule = await SplashModule.initialize(
        sharedPreferences: mockPrefs,
      );

      await preloadFonts(tester);

      await tester.pumpWidget(
        MultiProvider(
          providers: splashModule.providers,
          child: Localizations(
            delegates: AppLocalizations.localizationsDelegates,
            locale: const Locale("en"),
            child: const SplashFader(),
          ),
        ),
      );
      expect(tester.hasRunningAnimations, false);
      expect(find.byKey(SplashFader.splashKey), findsOneWidget);
      expect(find.byKey(SplashFader.childKey), findsNothing);
      expect(find.byKey(DansdataLogo.titleKey), findsOneWidget);
      expect(find.byKey(DansdataLogo.taglineKey), findsOneWidget);
      expect(find.text("Hello World"), findsNothing);

      await tester.pumpWidget(
        MultiProvider(
          providers: splashModule.providers,
          child: Localizations(
            delegates: AppLocalizations.localizationsDelegates,
            locale: const Locale("en"),
            child: const SplashFader(
              child: Text("Hello World", key: SplashFader.childKey),
            ),
          ),
        ),
      );
      // Make sure the fader intends to animate the transition.
      expect(tester.hasRunningAnimations, true);
      await tester.pumpAndSettle();
      expect(find.byKey(SplashFader.splashKey), findsNothing);
      expect(find.byKey(SplashFader.childKey), findsOneWidget);
      expect(find.byKey(DansdataLogo.titleKey), findsNothing);
      expect(find.byKey(DansdataLogo.taglineKey), findsNothing);
      expect(find.text("Hello World"), findsOneWidget);
    },
    skip: !TestEnvironment.testSuite.unit,
  );
}
