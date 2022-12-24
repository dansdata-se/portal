import "package:flutter/foundation.dart";

abstract class Setting<T> with ChangeNotifier {
  late T _value;

  /// Retrieves the (cached) value of this setting.
  T get value => _value;

  Future<void> initialize() async {
    _value = await loadValue();
  }

  /// Updates the setting with a new value.
  ///
  /// The cached value will be updated immediately. The returned future can be
  /// awaited to detect when the setting has been written to persistent storage.
  Future<void> update(T newValue) async {
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
