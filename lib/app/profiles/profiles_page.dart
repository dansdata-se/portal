import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/routing/page.dart";

class ProfilesDestination extends DestinationWithoutParams {
  const ProfilesDestination();

  @override
  final String location = "/profiles";

  @override
  String getLabel(AppLocalizations t) => t.labelProfiles;

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const ProfilesPage(),
      );
}

class ProfilesPage extends StatelessPage {
  static const Key pageKey = Key("profilesPage.pageKey");

  const ProfilesPage({super.key})
      : super(destination: const ProfilesDestination());

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      key: pageKey,
      color: theme.colorScheme.background,
      child: Text(
        t.labelProfiles,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}
