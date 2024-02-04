import "package:signals/signals.dart" as signals;

abstract class ViewModel {
  final _disposeEffectCallbacks =
      List<signals.EffectCleanup>.empty(growable: true);

  /// Called once on startup, allowing this [ViewModel] to configure local
  /// bindings and effects.
  ///
  /// Note that this method is invoked during the initial widget build.
  /// Therefore, you must not perform actions here that would require parent
  /// components to rebuild. Instead, see [initGlobalState] for such use-cases.
  void initLocalState() {}

  /// Called once on startup, allowing this [ViewModel] to configure global
  /// bindings and effects.
  ///
  /// This method is invoked as part of a post-frame callback.
  void initGlobalState() {}

  void dispose() {
    for (var dispose in _disposeEffectCallbacks) {
      dispose();
    }
  }

  /// Wrapper around [signals.effect] which automatically disposes the effect
  /// when the [ViewModel] is disposed.
  void viewModelEffect(Function() compute, {String? debugLabel}) {
    final dispose = signals.effect(compute, debugLabel: debugLabel);
    _disposeEffectCallbacks.add(dispose);
  }
}
