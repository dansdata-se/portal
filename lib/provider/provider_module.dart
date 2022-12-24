import "package:flutter/foundation.dart";
import "package:provider/provider.dart";
import "package:provider/single_child_widget.dart";

abstract class ProviderModule {
  final List<SingleChildWidget> _providers = [];

  List<SingleChildWidget> get providers => _providers;

  @protected
  void register(SingleChildWidget provider) {
    _providers.add(provider);
  }

  @protected
  void registerAll(List<SingleChildWidget> providers) {
    _providers.addAll(providers);
  }

  @protected
  void registerValue<T>(T value) => register(
        ValueListenableProvider<T>.value(
          value: ValueNotifier(value),
        ),
      );

  @protected
  void registerChangeNotifier<T extends ChangeNotifier>(
    T value,
  ) =>
      register(ChangeNotifierProvider<T>.value(value: value));
}
