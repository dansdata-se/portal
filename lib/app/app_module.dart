import "package:logger/logger.dart";
import "package:portal/app/state/page_title_state.dart";
import "package:portal/app/theme/theme_mode_setting.dart";
import "package:portal/l10n/language_setting.dart";
import "package:portal/logger/portal_log_filter.dart";
import "package:portal/provider/provider_module.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Global dependencies for the main application.
class AppModule extends ProviderModule {
  AppModule._(
    this.logger,
    this.sharedPreferences,
    this.pageTitleState,
    this.themeModeSetting,
    this.languageSetting,
  ) {
    registerValue<Logger>(logger);
    registerValue<SharedPreferences>(sharedPreferences);
    registerChangeNotifier<PageTitleState>(pageTitleState);
    registerChangeNotifier<ThemeModeSetting>(themeModeSetting);
    registerChangeNotifier<LanguageSetting>(languageSetting);
  }

  final Logger logger;
  final SharedPreferences sharedPreferences;
  final PageTitleState pageTitleState;
  final ThemeModeSetting themeModeSetting;
  final LanguageSetting languageSetting;

  static Future<AppModule> initialize({
    Logger? logger,
    SharedPreferences? sharedPreferences,
    PageTitleState? pageTitleState,
    ThemeModeSetting? themeModeSetting,
    LanguageSetting? languageSetting,
  }) async {
    List<Future<void>> futures = [];

    logger ??= Logger(
      filter: PortalLogFilter(),
      printer: PrettyPrinter(printTime: true, lineLength: 72, colors: true),
    );
    if (sharedPreferences == null) {
      futures.add(
        SharedPreferences.getInstance()
            .then((value) => sharedPreferences = value),
      );
    }
    if (pageTitleState == null) {
      pageTitleState = PageTitleState();
      futures.add(pageTitleState.initialize());
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
      pageTitleState,
      themeModeSetting,
      languageSetting,
    );
  }
}
