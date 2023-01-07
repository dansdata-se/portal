import "package:flutter/foundation.dart";

/// Wrapper for a single value.
///
/// States *must* be initialized via the [initialize] method before use.
abstract class State<T> with ChangeNotifier {
  bool _initialized = false;
  bool _disposed = false;

  @protected
  bool get isInitialized => _initialized;
  @protected
  bool get isDisposed => _disposed;

  /// The value of this state.
  T get value;

  /// Updates the state with a new value.
  ///
  /// The returned future can be awaited to detect when the state change has
  /// been completed.
  Future<void> update(T newValue);

  /// Initializes the state, e.g. allowing listeners to be set up.
  ///
  /// The [value] of this state may not be accessed before [initialized] is
  /// called!
  @mustCallSuper
  Future<void> initialize() async {
    if (kDebugMode) {
      if (_initialized) throw StateError("State is already intialized");
      if (_disposed) throw StateError("State is disposed");
    }

    _initialized = true;
  }

  /// Removes any registered listeners and disposes of this state.
  ///
  /// A disposed state cannot be re-initialized.
  @override
  @mustCallSuper
  Future<void> dispose() async {
    if (kDebugMode) {
      if (!_initialized) throw StateError("State is not intialized");
      if (_disposed) throw StateError("State is already disposed");
    }

    _disposed = true;
    super.dispose();
  }
}
