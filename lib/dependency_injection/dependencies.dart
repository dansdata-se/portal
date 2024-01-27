import "package:flutter/widgets.dart";
import "package:get_it/get_it.dart";

class Dependencies extends InheritedWidget {
  const Dependencies({
    super.key,
    required GetIt injector,
    required super.child,
  }) : _injector = injector;

  final GetIt _injector;

  T get<T extends Object>() => _injector.get<T>();

  @override
  bool updateShouldNotify(covariant Dependencies oldWidget) {
    assert(_injector == oldWidget._injector);
    return _injector != oldWidget._injector;
  }

  static Dependencies? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Dependencies>();

  static Dependencies of(BuildContext context) {
    final Dependencies? result = maybeOf(context);
    assert(result != null, "No Dependencies found in context");
    return result!;
  }
}
