import "package:flutter/src/widgets/framework.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/src/route.dart";
import "package:portal/app/routing/destination.dart";

import "../../test_environment.dart";

class DestinationWithoutParamsA extends DestinationWithoutParams {
  @override
  final String location = "/destination/a";

  @override
  String getLabel(AppLocalizations t) => "Destination A";

  @override
  RouteBase build() => throw UnimplementedError();
}

class DestinationWithParamsA extends DestinationWithParams {
  @override
  final String location = "/destination/a";

  @override
  RouteBase build() => throw UnimplementedError();

  @override
  String getLabel(AppLocalizations t) => "Destination A";

  @override
  void go(BuildContext context, params) => throw UnimplementedError();

  @override
  void push(BuildContext context, params) => throw UnimplementedError();
}

class DestinationWithoutParamsB extends DestinationWithoutParams {
  @override
  final String location = "/destination/b";

  @override
  String getLabel(AppLocalizations t) => "Destination B";

  @override
  RouteBase build() => throw UnimplementedError();
}

class DestinationWithParamsB extends DestinationWithParams {
  @override
  final String location = "/destination/b";

  @override
  String getLabel(AppLocalizations t) => "Destination B";

  @override
  RouteBase build() => throw UnimplementedError();

  @override
  void go(BuildContext context, params) => throw UnimplementedError();

  @override
  void push(BuildContext context, params) => throw UnimplementedError();
}

void main() {
  test(
    "equality operator",
    () async {
      Destination first = DestinationWithoutParamsA();
      Destination second = DestinationWithoutParamsA();
      expect(first, equals(second));

      first = DestinationWithParamsA();
      second = DestinationWithParamsA();
      expect(first, equals(second));

      first = DestinationWithParamsA();
      second = DestinationWithoutParamsA();
      expect(first, equals(second));

      first = DestinationWithParamsA();
      second = DestinationWithParamsB();
      expect(first, isNot(equals(second)));

      first = DestinationWithParamsA();
      second = DestinationWithoutParamsB();
      expect(first, isNot(equals(second)));

      first = DestinationWithParamsB();
      second = DestinationWithParamsB();
      expect(first, equals(second));

      first = DestinationWithParamsB();
      second = DestinationWithoutParamsB();
      expect(first, equals(second));
    },
    skip: !TestEnvironment.testSuite.smoke,
  );
}
