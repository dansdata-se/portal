import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_web_plugins/url_strategy.dart" deferred as url_strategy;
import "package:google_fonts/google_fonts.dart";
import "package:portal/app/app.dart" deferred as app;
import "package:portal/app/app_module.dart" deferred as app_module;
import "package:portal/app/splash/splash_fader.dart";
import "package:portal/app/splash/splash_module.dart";
import "package:portal/gen/assets.gen.dart";
import "package:portal/vercel/vercel_env.dart";
import "package:provider/provider.dart";

// Note that <Primitive>.fromEnvironment loads its variables at build time!
// https://github.com/dart-lang/sdk/issues/27585
class BuildConfig {
  static final Uri supabaseUrl = Uri.parse(
    const String.fromEnvironment(
      "SUPABASE_URL",
      defaultValue: "http://localhost:54321",
    ),
  );
  static const String supabaseAnonKey = String.fromEnvironment(
    "SUPABASE_ANON_KEY",
    defaultValue:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24ifQ.625_WdcF3KHqz5amU0x2X5WWHP-OEs_4qj0ssLNHzTs",
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
  // Minimal initialization only!
  // This is to allow the splash screen to appear as early as possible.
  GoogleFonts.config.allowRuntimeFetching = false;
  // Required to fetch the current dark mode setting before runApp() is
  // completed.
  WidgetsFlutterBinding.ensureInitialized();
  final splashModule = await SplashModule.initialize();
  runApp(
    MultiProvider(
      providers: splashModule.providers,
      child: const SplashFader(),
    ),
  );

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(Assets.googleFonts.ofl);
    yield LicenseEntryWithLineBreaks(["google_fonts"], license);
  });

  dynamic appModule;
  await Future.wait([
    // Minimum time to show splash screen for
    Future.delayed(const Duration(seconds: 2)),
    url_strategy.loadLibrary(),
    app.loadLibrary(),
    app_module.loadLibrary().then((_) async {
      appModule = await app_module.AppModule.initialize();
    }),
  ]);

  url_strategy.usePathUrlStrategy();

  runApp(
    MultiProvider(
      providers: appModule.providers,
      child:
          // Cannot use const constructor as DansdataPortalApp is dynamically loaded.
          // ignore: prefer_const_constructors
          SplashFader(child: app.DansdataPortalApp(key: SplashFader.childKey)),
    ),
  );
}
