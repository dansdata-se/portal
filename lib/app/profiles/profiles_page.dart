import "package:flutter/material.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/navigation/destination.dart";
import "package:portal/app/theme/paddings.dart";

class ProfilesDestination extends DestinationWithoutParams {
  const ProfilesDestination();

  @override
  final String location = "/profiles";

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const ProfilesPage(),
      );
}

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        color: theme.colorScheme.background,
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            Breakpoints.small.isActive(context)
                ? Paddings.small
                : Paddings.large,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Paddings.extraExtraLarge,
                  horizontal: Paddings.large,
                ),
                child: Text(
                  t.labelProfiles,
                  style: theme.textTheme.displayLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
