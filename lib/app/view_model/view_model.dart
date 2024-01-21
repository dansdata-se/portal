import "package:signals/signals.dart" as signals;

abstract class ViewModel {
  final _disposeEffectCallbacks =
      List<signals.EffectCleanup>.empty(growable: true);

  void init() {}

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
