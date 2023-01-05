import "package:shared_preferences/shared_preferences.dart";

extension EnumSharedPreferences on SharedPreferences {
  T getEnum<T extends Enum>(
    String key,
    List<T> enumValues,
    T Function() fallbackProvider,
  ) =>
      getEnumOrNull(key, enumValues) ?? fallbackProvider();

  T? getEnumOrNull<T extends Enum>(String key, List<T> enumValues) {
    String? storedName = getString(key);
    if (storedName == null) return null;
    try {
      return enumValues.firstWhere(
        (element) => element.name == storedName,
      );
    } on StateError {
      return null;
    }
  }

  Future<bool> setEnum<T extends Enum>(String key, T value) async =>
      setString(key, value.name);
}
