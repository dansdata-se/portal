import "package:logger/logger.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/provider/provider_module.dart";
import "package:shared_preferences/shared_preferences.dart";

/// [ProviderModule] which provides the dependencies required by the splash
/// screen.
///
/// This module should be as minimal as possible to reduce time to first
/// contentful paint.
class SplashModule extends ProviderModule {
  SplashModule._(
    this.logger,
    this.sharedPreferences,
    this.themeModeSetting,
    this.languageSetting,
  ) {
    registerValue<Logger>(logger);
    registerValue<SharedPreferences>(sharedPreferences);
    registerChangeNotifier<ThemeModeSetting>(themeModeSetting);
    registerChangeNotifier<LanguageSetting>(languageSetting);
  }

  final Logger logger;
  final SharedPreferences sharedPreferences;
  final ThemeModeSetting themeModeSetting;
  final LanguageSetting languageSetting;

  static Future<SplashModule> initialize({
    Logger? logger,
    SharedPreferences? sharedPreferences,
    ThemeModeSetting? themeModeSetting,
    LanguageSetting? languageSetting,
  }) async {
    List<Future<void>> futures = [];

    logger ??= Logger(
      printer: PrettyPrinter(printTime: true, lineLength: 72, colors: true),
    );
    if (sharedPreferences == null) {
      futures.add(
        SharedPreferences.getInstance()
            .then((value) => sharedPreferences = value),
      );
    }

    await Future.wait(futures);
    futures.clear();

    if (themeModeSetting == null) {
      themeModeSetting = ThemeModeSetting(sharedPreferences!);
      futures.add(themeModeSetting.initialize());
    }
    if (languageSetting == null) {
      languageSetting = LanguageSetting(logger, sharedPreferences!);
      futures.add(languageSetting.initialize());
    }

    await Future.wait(futures);
    futures.clear();

    return SplashModule._(
      logger,
      sharedPreferences!,
      themeModeSetting,
      languageSetting,
    );
  }
}
