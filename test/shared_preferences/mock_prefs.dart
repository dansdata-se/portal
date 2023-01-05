import "package:shared_preferences/shared_preferences.dart";

class MockPrefs implements SharedPreferences {
  MockPrefs(this.data);

  final Map<String, Object?> data;

  @override
  Future<bool> clear() async {
    data.clear();
    return true;
  }

  @override
  Future<bool> commit() async => true;

  @override
  bool containsKey(String key) => data.containsKey(key);

  @override
  Object? get(String key) => data[key];

  @override
  bool? getBool(String key) => get(key) as bool?;

  @override
  double? getDouble(String key) => get(key) as double?;

  @override
  int? getInt(String key) => get(key) as int?;

  @override
  Set<String> getKeys() => data.keys.toSet();

  @override
  String? getString(String key) => get(key) as String?;

  @override
  List<String>? getStringList(String key) => get(key) as List<String>?;

  @override
  Future<void> reload() async {}

  @override
  Future<bool> remove(String key) async {
    if (!data.containsKey(key)) return false;

    data.remove(key);
    return true;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    data[key] = value;
    return true;
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    data[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    data[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    data[key] = value;
    return true;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    data[key] = value;
    return true;
  }
}
