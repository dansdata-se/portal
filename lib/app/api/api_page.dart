import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/routing/page.dart";

class ApiDestination extends DestinationWithoutParams {
  const ApiDestination();

  @override
  final String location = "/api";

  @override
  String getLabel(AppLocalizations t) => t.labelApi;

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const ApiPage(),
      );
}

class ApiPage extends StatelessPage {
  static const Key pageKey = Key("apiPage.pageKey");

  const ApiPage({super.key}) : super(destination: const ApiDestination());

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      key: pageKey,
      color: theme.colorScheme.background,
      child: Text(
        t.labelApi,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}
