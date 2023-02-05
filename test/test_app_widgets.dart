import "package:flutter/widgets.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:meta/meta.dart";
import "package:mockito/annotations.dart";
import "package:portal/app/app.dart";
import "package:portal/app/app_module.dart";
@GenerateNiceMocks([MockSpec<AuthService>()])
import "package:portal/app/auth/auth_service.dart";
import "package:provider/provider.dart";

import "google_fonts/preload_fonts.dart";
import "shared_preferences/mock_prefs.dart";
import "test_app_widgets.mocks.dart";

typedef AppTestWrapper = Widget Function({
  required AppModule appModule,
  required Widget child,
});

/// Wrapper for [testWidgets] which:
/// 1. makes sure Google Fonts are loaded,
/// 2. configures a minimal [AppModule] suitable for use in tests (e.g. with
///    [AppModule.sharedPreferences] backed by [MockPrefs]), and
/// 3. provides an [AppTestWrapper] to put tested widgets inside, greatly
///    simplifying widget test setup.
@isTest
void testAppWidgets(
  String description,
  Future<void> Function(
    WidgetTester widgetTester,
    AppTestWrapper wrapper,
    AppModule appModule,
  )
      callback, {
  bool? skip,
  Timeout? timeout,
  bool semanticsEnabled = true,
  TestVariant<Object?> variant = const DefaultTestVariant(),
  dynamic tags,
}) {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets(
    description,
    (WidgetTester tester) async {
      final appModule = await AppModule.initialize(
        sharedPreferences: MockPrefs({}),
        authService: MockAuthService(),
      );

      await preloadFonts(tester);
      await callback(tester, _widgetWrapper, appModule);
    },
    skip: skip,
    timeout: timeout,
    semanticsEnabled: semanticsEnabled,
    variant: variant,
    tags: tags,
  );
}

/// A wrapper which configures an [AppModule]-based [MultiProvider] and a
/// [DansdataPortalApp] around a widget for testing.
Widget _widgetWrapper({
  required AppModule appModule,
  required Widget child,
}) {
  return MultiProvider(
    providers: appModule.providers,
    child: DansdataPortalApp(
      routerConfig: GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => child,
          ),
        ],
      ),
    ),
  );
}
