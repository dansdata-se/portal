import "package:logger/logger.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/provider/provider_module.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Global dependencies for the main application.
class AppModule extends ProviderModule {
  AppModule._(
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

  static Future<AppModule> initialize({
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

    return AppModule._(
      logger,
      sharedPreferences!,
      themeModeSetting,
      languageSetting,
    );
  }
}
