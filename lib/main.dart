import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:google_fonts/google_fonts.dart";
import "package:logger/logger.dart";
import "package:portal/app/app.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/gen/assets.gen.dart";
import "package:portal/vercel/vercel_env.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

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
  GoogleFonts.config.allowRuntimeFetching = false;

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(Assets.googleFonts.ofl);
    yield LicenseEntryWithLineBreaks(["google_fonts"], license);
  });

  final logger = Logger(
    printer: PrettyPrinter(printTime: true, lineLength: 72, colors: true),
  );
  final prefs = await SharedPreferences.getInstance();

  final languageSetting = LanguageSetting(logger, prefs);
  final themeModeSetting = ThemeModeSetting(prefs);

  await Future.wait([
    languageSetting.initialize(),
    themeModeSetting.initialize(),
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: languageSetting),
        ChangeNotifierProvider.value(value: themeModeSetting),
      ],
      child: const DansdataPortalApp(),
    ),
  );
}
