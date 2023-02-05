import "package:logger/logger.dart";
import "package:portal/app/auth/auth_controller.dart";
import "package:portal/app/auth/auth_service.dart";
import "package:portal/app/state/page_title_state.dart";
import "package:portal/app/theme/theme_mode_setting.dart";
import "package:portal/l10n/language_setting.dart";
import "package:portal/logger/portal_log_filter.dart";
import "package:portal/provider/provider_module.dart";
import "package:portal/supabase/supabase_auth_service.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Global dependencies for the main application.
class AppModule extends ProviderModule {
  AppModule._(
    this.logger,
    this.sharedPreferences,
    this.pageTitleState,
    this.authService,
    this.themeModeSetting,
    this.languageSetting,
    this.authController,
  ) {
    registerValue<Logger>(logger);
    registerValue<SharedPreferences>(sharedPreferences);
    registerChangeNotifier<PageTitleState>(pageTitleState);
    registerValue<AuthService>(authService);
    registerChangeNotifier<ThemeModeSetting>(themeModeSetting);
    registerChangeNotifier<LanguageSetting>(languageSetting);
    registerChangeNotifier<AuthController>(authController);
  }

  final Logger logger;
  final SharedPreferences sharedPreferences;
  final PageTitleState pageTitleState;
  final AuthService authService;
  final ThemeModeSetting themeModeSetting;
  final LanguageSetting languageSetting;
  final AuthController authController;

  static Future<AppModule> initialize({
    Logger? logger,
    SharedPreferences? sharedPreferences,
    PageTitleState? pageTitleState,
    AuthService? authService,
    ThemeModeSetting? themeModeSetting,
    LanguageSetting? languageSetting,
    AuthController? authController,
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
    if (authService == null) {
      futures.add(
        SupabaseAuthService.create(logger).then((value) => authService = value),
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
    authController ??= AuthController(authService!);

    await Future.wait(futures);
    futures.clear();

    return AppModule._(
      logger,
      sharedPreferences!,
      pageTitleState,
      authService!,
      themeModeSetting,
      languageSetting,
      authController,
    );
  }
}
