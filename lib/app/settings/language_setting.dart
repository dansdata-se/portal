import "dart:ui";

import "package:intl/intl.dart";
import "package:intl/intl_standalone.dart"
    if (dart.library.html) "package:intl/intl_browser.dart";
import "package:logger/logger.dart";
import "package:portal/app/settings/language.dart";
import "package:portal/app/settings/setting.dart";
import "package:portal/shared_preferences/enum_extensions.dart";
import "package:shared_preferences/shared_preferences.dart";

class LanguageSetting extends Setting<Language> {
  static const key = "dansdata_portal.settings.v1.language";

  LanguageSetting._(
    this._logger,
    this._sharedPreferences,
    this._initIntlSystemLocale,
  );

  LanguageSetting.forTesting(
    this._logger,
    this._sharedPreferences,
    this._initIntlSystemLocale,
  );

  factory LanguageSetting(
    Logger logger,
    SharedPreferences sharedPreferences,
  ) =>
      LanguageSetting._(logger, sharedPreferences, findSystemLocale);

  final Logger _logger;
  final SharedPreferences _sharedPreferences;
  final Future Function() _initIntlSystemLocale;

  Locale get locale {
    switch (value) {
      case Language.swedish:
        return const Locale("sv");
      case Language.english:
        return const Locale("en");
    }
  }

  Future<void> toggle() async {
    switch (value) {
      case Language.swedish:
        await update(Language.english);
        break;
      case Language.english:
        await update(Language.swedish);
        break;
    }
  }

  @override
  Future<Language> loadValue() async {
    final selectedLanguage =
        _sharedPreferences.getEnumOrNull(key, Language.values);
    if (selectedLanguage != null) {
      return selectedLanguage;
    }

    await _initIntlSystemLocale();
    final locale = Intl.shortLocale(Intl.systemLocale);

    switch (locale) {
      case "en":
        return Language.english;
      case "sv":
        return Language.swedish;
      default:
        _logger.w("Unknown locale '$locale' - falling back on swedish");
        return Language.swedish;
    }
  }

  @override
  Future<void> persistValue(Language value) =>
      _sharedPreferences.setEnum(key, value);
}
