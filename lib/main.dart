import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:google_fonts/google_fonts.dart";
import "package:kotlin_scope_function/kotlin_scope_function.dart";
import "package:portal/app/app.dart" deferred as app;
import "package:portal/app/app_module.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/app/splash_screen.dart";
import "package:portal/gen/assets.gen.dart";
import "package:portal/vercel/vercel_env.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

// Note that <Primitive>.fromEnvironment loads its variables at build time!
// https://github.com/dart-lang/sdk/issues/27585
class BuildConfig {
  static final Uri siteUrl = Uri.parse(
    const String.fromEnvironment(
      "VERCEL_URL",
      defaultValue: "http://localhost:3000",
    ).let((it) {
      String url = it;
      // Make sure to include `https://` when not localhost.
      url = (url.startsWith("https://") || url.startsWith("http://localhost"))
          ? url
          : "https://$url";
      // Make sure to including trailing `/`.
      url = url.endsWith("/") ? url : "$url/";
      return url;
    }),
  );
  static final Uri supabaseUrl = Uri.parse(
    const String.fromEnvironment(
      "SUPABASE_URL",
      defaultValue: "http://localhost:54321",
    ),
  );
  static const String supabaseAnonKey = String.fromEnvironment(
    "SUPABASE_ANON_KEY",
    defaultValue:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0",
  );
  static final VercelEnv vercelEnv = VercelEnv.values.byName(
    const String.fromEnvironment(
      "VERCEL_ENV",
      defaultValue: "development",
    ),
  );
  static const String gitCommitRef = String.fromEnvironment(
    "GIT_COMMIT_REF",
    defaultValue: "unknown",
  );
  static const String gitCommitSha = String.fromEnvironment(
    "GIT_COMMIT_SHA",
    defaultValue: "unknown",
  );
}

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;

  final sharedPreferences = await SharedPreferences.getInstance();
  final themeModeSetting = ThemeModeSetting(sharedPreferences);
  final languageSetting =
      LanguageSetting(AppModule.defaultLogger, sharedPreferences);
  await Future.wait([
    themeModeSetting.initialize(),
    languageSetting.initialize(),
  ]);
  final themeMode = themeModeSetting.value;
  final locale = languageSetting.locale;

  runApp(
    SplashScreen(
      themeMode: themeMode,
      locale: locale,
    ),
  );

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(Assets.googleFonts.ofl);
    yield LicenseEntryWithLineBreaks(["google_fonts"], license);
  });

  usePathUrlStrategy();

  // Initialize providers and fade out the splash screen.
  runApp(
    InitWidget(
      initialThemeMode: themeMode,
      initialLocale: locale,
    ),
  );
}

class InitWidget extends StatefulWidget {
  const InitWidget({
    super.key,
    required this.initialThemeMode,
    required this.initialLocale,
  });

  final ThemeMode initialThemeMode;
  final Locale initialLocale;

  @override
  State<StatefulWidget> createState() => _InitWidgetState();
}

class _InitWidgetState extends State<InitWidget> {
  static const minSplashDuration = Duration(seconds: 2);
  Widget? _appWidget;

  Future<void> _init() async {
    final sw = Stopwatch()..start();

    final result = await Future.wait([
      AppModule.initialize(),
      app.loadLibrary(),
    ]);
    final AppModule appModule = result[0];

    final remaining = minSplashDuration - sw.elapsed;
    if (!remaining.isNegative) {
      await Future.delayed(remaining);
    }

    setState(() {
      _appWidget = MultiProvider(
        providers: appModule.providers,
        // Deferred classes can't be created with 'const'.
        // ignore: prefer_const_constructors
        child: app.DansdataPortalApp(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    unawaited(_init());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: _appWidget ??
          SplashScreen(
            themeMode: widget.initialThemeMode,
            locale: widget.initialLocale,
          ),
    );
  }
}
