import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/routing/page.dart";

class DashboardDestination extends DestinationWithoutParams {
  const DashboardDestination();

  @override
  final String location = "/dashboard";

  @override
  String getLabel(AppLocalizations t) => t.labelDashboard;

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const DashboardPage(),
      );
}

class DashboardPage extends StatelessPage {
  static const Key pageKey = Key("dashboardPage.pageKey");

  const DashboardPage({super.key})
      : super(destination: const DashboardDestination());

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      key: pageKey,
      color: theme.colorScheme.background,
      child: Text(
        t.labelDashboard,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}
