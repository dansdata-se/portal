import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/routing/page.dart";

class EventsDestination extends DestinationWithoutParams {
  const EventsDestination();

  @override
  final String location = "/events";

  @override
  String getLabel(AppLocalizations t) => t.labelEvents;

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const EventsPage(),
      );
}

class EventsPage extends StatelessPage {
  static const Key pageKey = Key("eventsPage.pageKey");

  const EventsPage({super.key}) : super(destination: const EventsDestination());

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      key: pageKey,
      color: theme.colorScheme.background,
      child: Text(
        t.labelEvents,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}
