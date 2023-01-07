import "package:flutter/foundation.dart";

/// A single setting that is persisted between app runs.
///
/// Settings *must* be initialized via the [initialize] method before use.
abstract class Setting<T> with ChangeNotifier {
  bool _initialized = false;
  bool _disposed = false;
  late T _value;

  /// Retrieves the (cached) value of this setting.
  T get value {
    if (kDebugMode) {
      if (!_initialized) throw StateError("Setting is not intialized");
      if (_disposed) throw StateError("Setting is disposed");
    }

    return _value;
  }

  /// Initializes and loads the initial value of this setting
  @mustCallSuper
  Future<void> initialize() async {
    if (kDebugMode) {
      if (_initialized) throw StateError("Setting is already intialized");
      if (_disposed) throw StateError("Setting is disposed");
    }

    _initialized = true;
    _value = await loadValue();
  }

  /// Initializes and loads the initial value of this setting
  @override
  @mustCallSuper
  Future<void> dispose() async {
    if (kDebugMode) {
      if (!_initialized) throw StateError("Setting is not intialized");
      if (_disposed) throw StateError("Setting is already disposed");
    }

    _disposed = true;
    super.dispose();
  }

  /// Updates the setting with a new value.
  ///
  /// The cached value will be updated immediately. The returned future can be
  /// awaited to detect when the setting has been written to persistent storage.
  Future<void> update(T newValue) async {
    if (kDebugMode) {
      if (!_initialized) throw StateError("Setting is not intialized");
      if (_disposed) throw StateError("Setting is disposed");
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
