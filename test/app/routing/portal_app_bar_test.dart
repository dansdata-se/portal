import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:google_fonts/google_fonts.dart";
import "package:portal/app/app_module.dart";
import "package:portal/app/routing/portal_app_bar.dart";
import "package:portal/l10n/language.dart";

import "../../google_fonts/preload_fonts.dart";
import "../../shared_preferences/mock_prefs.dart";
import "../../test_environment.dart";
import "../widget_test_wrapper.dart";

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets(
    "theme mode button handles unconfigured theme",
    (WidgetTester tester) async {
      final appModule = await AppModule.initialize(
        sharedPreferences: MockPrefs({}),
      );

      await preloadFonts(tester);

      await tester.pumpWidget(
        WidgetTestWrapper(
          appModule: appModule,
          child: Builder(
            builder: (context) => Scaffold(appBar: PortalAppBar.of(context)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(appModule.themeModeSetting.value, ThemeMode.system);
      await tester.tap(find.byKey(PortalAppBar.themeModeToggleKey));
      await tester.pumpAndSettle();
      expect(
        appModule.themeModeSetting.value,
        isIn([ThemeMode.light, ThemeMode.dark]),
      );
    },
    skip: !TestEnvironment.testSuite.unit,
  );

  testWidgets(
    "theme mode button changes theme mode",
    (WidgetTester tester) async {
      final appModule = await AppModule.initialize(
        sharedPreferences: MockPrefs({}),
      );
      await appModule.themeModeSetting.update(ThemeMode.light);

      await preloadFonts(tester);

      await tester.pumpWidget(
        WidgetTestWrapper(
          appModule: appModule,
          child: Builder(
            builder: (context) => Scaffold(appBar: PortalAppBar.of(context)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(appModule.themeModeSetting.value, ThemeMode.light);
      await tester.tap(find.byKey(PortalAppBar.themeModeToggleKey));
      await tester.pumpAndSettle();
      expect(appModule.themeModeSetting.value, ThemeMode.dark);
      await tester.tap(find.byKey(PortalAppBar.themeModeToggleKey));
      await tester.pumpAndSettle();
      expect(appModule.themeModeSetting.value, ThemeMode.light);
    },
    skip: !TestEnvironment.testSuite.unit,
  );

  testWidgets(
    "language button changes language",
    (WidgetTester tester) async {
      final appModule = await AppModule.initialize(
        sharedPreferences: MockPrefs({}),
      );
      await appModule.languageSetting.update(Language.english);

      await preloadFonts(tester);

      await tester.pumpWidget(
        WidgetTestWrapper(
          appModule: appModule,
          child: Builder(
            builder: (context) => Scaffold(appBar: PortalAppBar.of(context)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(appModule.languageSetting.value, Language.english);
      await tester.tap(find.byKey(PortalAppBar.languageToggleKey));
      await tester.pumpAndSettle();
      expect(appModule.languageSetting.value, Language.swedish);
      await tester.tap(find.byKey(PortalAppBar.languageToggleKey));
      await tester.pumpAndSettle();
      expect(appModule.languageSetting.value, Language.english);
    },
    skip: !TestEnvironment.testSuite.unit,
  );
}
