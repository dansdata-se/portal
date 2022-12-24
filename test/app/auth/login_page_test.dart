import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:google_fonts/google_fonts.dart";
import "package:portal/app/app.dart";
import "package:portal/app/app_module.dart";
import "package:portal/app/auth/account.dart";
import "package:portal/app/auth/account_provider.dart";
import "package:portal/app/auth/login_form.dart";
import "package:portal/app/auth/login_result.dart";
import "package:portal/app/auth/user_service.dart";
import "package:portal/app/settings/language.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/components/portal_app_bar.dart";
import "package:provider/provider.dart";

import "../../google_fonts/preload_fonts.dart";
import "../../shared_preferences/mock_prefs.dart";
import "../../test_environment.dart";
import "../../test_widgets_multi_resolution.dart";

class MockUserService extends UserService {
  @override
  Account? get currentAccount => null;

  @override
  Future<LoginResult> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<LoginResult> loginWithProvider(AccountProvider accountProvider) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount() {
    throw UnimplementedError();
  }
}

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;

  group("dark mode toggle retains page state", () {
    testWidgetsMultiResolution(
      TestScreenSizes.values.map((e) => e.size).toList(growable: false),
      (WidgetTester tester, _) async {
        final userService = MockUserService();
        final mockPrefs = MockPrefs({
          ThemeModeSetting.key: ThemeMode.light.name,
          LanguageSetting.key: Language.english.name,
        });
        final appModule = await AppModule.initialize(
          sharedPreferences: mockPrefs,
          userService: userService,
        );

        await preloadFonts(tester);

        await tester.pumpWidget(
          MultiProvider(
            providers: appModule.providers,
            child: const DansdataPortalApp(),
          ),
        );
        await tester.pumpAndSettle();

        // Validate assumption: app is in light theme
        expect(appModule.themeModeSetting.value, ThemeMode.light);
        expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);

        // Input some text
        expect(find.byKey(LoginForm.emailFieldKey), findsOneWidget);
        await tester.enterText(find.byKey(LoginForm.emailFieldKey), "a@b.c");
        expect(
          tester
              .widget<TextFormField>(find.byKey(LoginForm.emailFieldKey))
              .controller!
              .text,
          "a@b.c",
        );

        // Switch to dark mode
        await tester.tap(find.byIcon(Icons.dark_mode_outlined));
        await tester.pumpAndSettle();

        // Validate assumption: app is in dark mode
        expect(appModule.themeModeSetting.value, ThemeMode.dark);
        expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);

        // Validate that text is still present in text field (a.k.a. state was
        // retained through dark mode toggle).
        expect(find.byKey(LoginForm.emailFieldKey), findsOneWidget);
        expect(
          tester
              .widget<TextFormField>(find.byKey(LoginForm.emailFieldKey))
              .controller!
              .text,
          "a@b.c",
        );
      },
      skip: (size) => size == TestScreenSizes.fullHd.size
          ? !TestEnvironment.testSuite.smoke
          : !TestEnvironment.testSuite.unit,
    );
  });

  group("language toggle retains page state", () {
    testWidgetsMultiResolution(
      TestScreenSizes.values.map((e) => e.size).toList(growable: false),
      (WidgetTester tester, _) async {
        final userService = MockUserService();
        final mockPrefs = MockPrefs({
          ThemeModeSetting.key: ThemeMode.light.name,
          LanguageSetting.key: Language.english.name,
        });
        final appModule = await AppModule.initialize(
          sharedPreferences: mockPrefs,
          userService: userService,
        );

        await preloadFonts(tester);

        await tester.pumpWidget(
          MultiProvider(
            providers: appModule.providers,
            child: const DansdataPortalApp(),
          ),
        );
        await tester.pumpAndSettle();

        // Validate assumption: app is in english
        expect(appModule.languageSetting.value, Language.english);

        // Validate assumption: screen has language toggle key
        expect(find.byKey(PortalAppBar.languageToggleKey), findsOneWidget);

        // Input some text
        expect(find.byKey(LoginForm.emailFieldKey), findsOneWidget);
        await tester.enterText(find.byKey(LoginForm.emailFieldKey), "a@b.c");
        expect(
          tester
              .widget<TextFormField>(find.byKey(LoginForm.emailFieldKey))
              .controller!
              .text,
          "a@b.c",
        );

        // Switch language
        await tester.tap(find.byKey(PortalAppBar.languageToggleKey));
        await tester.pumpAndSettle();

        // Validate assumption: app is not in english
        expect(appModule.languageSetting.value, isNot(Language.english));

        // Validate that text is still present in text field (a.k.a. state was
        // retained through language toggle).
        expect(find.byKey(LoginForm.emailFieldKey), findsOneWidget);
        expect(
          tester
              .widget<TextFormField>(find.byKey(LoginForm.emailFieldKey))
              .controller!
              .text,
          "a@b.c",
        );
      },
      skip: (size) => size == TestScreenSizes.fullHd.size
          ? !TestEnvironment.testSuite.smoke
          : !TestEnvironment.testSuite.unit,
    );
  });
}
