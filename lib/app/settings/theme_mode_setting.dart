import "package:flutter/material.dart";
import "package:portal/app/settings/setting.dart";
import "package:portal/shared_preferences/enum_extensions.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeModeSetting extends Setting<ThemeMode> {
  static const key = "dansdata_portal.settings.v1.theme_mode";

  ThemeModeSetting(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

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
