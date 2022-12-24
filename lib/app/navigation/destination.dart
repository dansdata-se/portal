import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";

abstract class _Destination {
  const _Destination();

  abstract final String location;
  RouteBase build();
}

abstract class DestinationWithParams<T> extends _Destination {
  const DestinationWithParams();

  void go(BuildContext context, T params);
  void push(BuildContext context, T params);
}

abstract class DestinationWithoutParams extends _Destination {
  const DestinationWithoutParams();

  void go(BuildContext context) => context.go(location);
  void push(BuildContext context) => context.push(location);
}
