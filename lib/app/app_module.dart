import "package:logger/logger.dart";
import "package:portal/app/auth/user_controller.dart";
import "package:portal/app/auth/user_service.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/logger/dansdata_log_filter.dart";
import "package:portal/provider/provider_module.dart";
import "package:portal/supabase/supabase_user_service.dart";
import "package:shared_preferences/shared_preferences.dart";

class AppModule extends ProviderModule {
  AppModule._(
    this.logger,
    this.sharedPreferences,
    this.userService,
    this.themeModeSetting,
    this.languageSetting,
    this.userController,
  ) {
    registerValue<Logger>(logger);
    registerValue<SharedPreferences>(sharedPreferences);
    registerValue<UserService>(userService);
    registerChangeNotifier<ThemeModeSetting>(themeModeSetting);
    registerChangeNotifier<LanguageSetting>(languageSetting);
    registerChangeNotifier<UserController>(userController);
  }

  final Logger logger;
  final SharedPreferences sharedPreferences;
  final UserService userService;
  final ThemeModeSetting themeModeSetting;
  final LanguageSetting languageSetting;
  final UserController userController;

  static final Logger defaultLogger = Logger(
    filter: DansdataLogFilter(),
    printer: PrettyPrinter(printTime: true, lineLength: 72, colors: true),
  );

  static Future<AppModule> initialize({
    Logger? logger,
    SharedPreferences? sharedPreferences,
    UserService? userService,
    ThemeModeSetting? themeModeSetting,
    LanguageSetting? languageSetting,
    UserController? userController,
  }) async {
    List<Future<void>> futures = [];

    logger ??= defaultLogger;
    if (sharedPreferences == null) {
      futures.add(
        SharedPreferences.getInstance()
            .then((value) => sharedPreferences = value),
      );
    }
    if (userService == null) {
      futures.add(
        SupabaseUserService.initialize(logger)
            .then((value) => userService = value),
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
    userController ??= UserController(userService!);

    await Future.wait(futures);
    futures.clear();

    return AppModule._(
      logger,
      sharedPreferences!,
      userService!,
      themeModeSetting,
      languageSetting,
      userController,
    );
  }
}
