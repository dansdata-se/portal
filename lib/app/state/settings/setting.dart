import "package:flutter/foundation.dart";
import "package:portal/app/state/state.dart";

/// An application setting that is persisted between app runs.
///
/// Settings *must* be initialized via the [initialize] method before use.
abstract class Setting<T> extends State<T> {
  late T _value;

  /// The (cached) value of this setting.
  @override
  T get value {
    if (kDebugMode) {
      if (!isInitialized) throw StateError("Setting is not intialized");
      if (isDisposed) throw StateError("Setting is disposed");
    }

    return _value;
  }

  /// Updates the setting with a new value.
  ///
  /// The cached value will be updated immediately. The returned future can be
  /// awaited to detect when the setting has been written to persistent storage.
  @override
  Future<void> update(T newValue) async {
    if (kDebugMode) {
      if (!isInitialized) throw StateError("Setting is not intialized");
      if (isDisposed) throw StateError("Setting is disposed");
    }

    _value = newValue;
    notifyListeners();
    await persistValue(newValue);
  }

  @override
  @mustCallSuper
  Future<void> initialize() async {
    await super.initialize();
    _value = await loadValue();
  }

  /// Load value from persistent storage.
  @protected
  Future<T> loadValue();

  /// Persist value to persistent storage.
  @protected
  Future<void> persistValue(T value);
}
