import "package:flutter/widgets.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";

/// A location within the app which can be navigated to.
///
/// Implementors should not extend [Destination] directly, but instead use
/// [DestinationWithParams] or [DestinationWithoutParams].
abstract class Destination {
  const Destination._();

  abstract final String location;

  /// The "label" of this [Destination], for use in navigation bars and page
  /// titles.
  String getLabel(AppLocalizations t);

  /// Builds the [RouteBase] (typically a [GoRoute]) associated with this
  /// [Destination].
  RouteBase build();

  @override
  String toString() => "Destination(location=$location)";

  /// Two destinations are equal if their [location] is equal,
  /// regardless of whether they have parameters or not!
  @override
  bool operator ==(Object other) =>
      other is Destination && other.location == location;

  @override
  int get hashCode => location.hashCode;
}

abstract class DestinationWithoutParams extends Destination {
  const DestinationWithoutParams() : super._();

  void go(BuildContext context) => context.go(location);
  void push(BuildContext context) => context.push(location);
}

abstract class DestinationWithParams<T> extends Destination {
  const DestinationWithParams() : super._();

  void go(BuildContext context, T params);
  void push(BuildContext context, T params);

  @override
  String toString() => "Destination<$T>(location=$location)";
}
