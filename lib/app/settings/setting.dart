import "package:flutter/foundation.dart";

/// A single setting that is persisted between app runs.
///
/// Settings *must* be initialized via the [initialize] method before use.
abstract class Setting<T> with ChangeNotifier {
  bool _initialized = false;
  late T _value;

  /// Retrieves the (cached) value of this setting.
  T get value {
    if (kDebugMode && !_initialized) {
      throw StateError("Setting is not intialized!");
    }

    return _value;
  }

  /// Initializes and loads the initial value of this setting
  @mustCallSuper
  Future<void> initialize() async {
    if (kDebugMode && _initialized) {
      throw StateError("Setting is already intialized");
    }

    _initialized = true;
    _value = await loadValue();
  }

  /// Updates the setting with a new value.
  ///
  /// The cached value will be updated immediately. The returned future can be
  /// awaited to detect when the setting has been written to persistent storage.
  Future<void> update(T newValue) async {
    if (kDebugMode && !_initialized) {
      throw StateError("Setting is not intialized!");
    }

    _value = newValue;
    notifyListeners();
    await persistValue(newValue);
  }

  /// Load value from persistent storage.
  @protected
  Future<T> loadValue();

  /// Persist value to persistent storage.
  @protected
  Future<void> persistValue(T value);
}
