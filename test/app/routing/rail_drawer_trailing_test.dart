import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:portal/app/app_module.dart";
import "package:portal/app/routing/rail_drawer_trailing.dart";
import "package:portal/l10n/language.dart";

import "../../test_app_widgets.dart";
import "../../test_environment.dart";

void main() {
  testAppWidgets(
    "theme mode button handles unconfigured theme",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      await tester.pumpWidget(
        wrapper(
          appModule: appModule,
          child: const RailDrawerTrailing(),
        ),
      );
      await tester.pumpAndSettle();

      expect(appModule.themeModeSetting.value, ThemeMode.system);
      await tester.tap(find.byKey(RailDrawerTrailing.themeModeToggleKey));
      await tester.pumpAndSettle();
      expect(
        appModule.themeModeSetting.value,
        isIn([ThemeMode.light, ThemeMode.dark]),
      );
    },
    skip: !TestEnvironment.testSuite.unit,
  );

  testAppWidgets(
    "theme mode button changes theme mode",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      await appModule.themeModeSetting.update(ThemeMode.light);

      await tester.pumpWidget(
        wrapper(
          appModule: appModule,
          child: const RailDrawerTrailing(),
        ),
      );
      await tester.pumpAndSettle();

      expect(appModule.themeModeSetting.value, ThemeMode.light);
      await tester.tap(find.byKey(RailDrawerTrailing.themeModeToggleKey));
      await tester.pumpAndSettle();
      expect(appModule.themeModeSetting.value, ThemeMode.dark);
      await tester.tap(find.byKey(RailDrawerTrailing.themeModeToggleKey));
      await tester.pumpAndSettle();
      expect(appModule.themeModeSetting.value, ThemeMode.light);
    },
    skip: !TestEnvironment.testSuite.unit,
  );

  testAppWidgets(
    "language button changes language",
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      await appModule.languageSetting.update(Language.english);

      await tester.pumpWidget(
        wrapper(
          appModule: appModule,
          child: const RailDrawerTrailing(),
        ),
      );
      await tester.pumpAndSettle();

      expect(appModule.languageSetting.value, Language.english);
      await tester.tap(find.byKey(RailDrawerTrailing.languageToggleKey));
      await tester.pumpAndSettle();
      expect(appModule.languageSetting.value, Language.swedish);
      await tester.tap(find.byKey(RailDrawerTrailing.languageToggleKey));
      await tester.pumpAndSettle();
      expect(appModule.languageSetting.value, Language.english);
    },
    skip: !TestEnvironment.testSuite.unit,
  );
}
