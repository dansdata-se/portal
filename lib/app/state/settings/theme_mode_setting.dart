import "package:flutter/material.dart";
import "package:portal/app/state/settings/setting.dart";
import "package:portal/shared_preferences/enum_extensions.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeModeSetting extends Setting<ThemeMode> with WidgetsBindingObserver {
  static const key = "dansdata_portal.settings.v1.theme_mode";

  ThemeModeSetting(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  bool get isDarkTheme {
    switch (value) {
      case ThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
    }
  }

  @override
  Future<void> initialize() async {
    await super.initialize();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    notifyListeners();
  }

  @override
  Future<ThemeMode> loadValue() async => sharedPreferences.getEnum(
        key,
        ThemeMode.values,
        () => ThemeMode.system,
      );

  @override
  Future<void> persistValue(ThemeMode value) =>
      sharedPreferences.setEnum(key, value);
}
