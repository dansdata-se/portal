import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/auth/user_controller.dart";
import "package:portal/app/navigation/destination.dart";
import "package:portal/app/theme/paddings.dart";
import "package:provider/provider.dart";

class AccountDestination extends DestinationWithoutParams {
  const AccountDestination();

  @override
  final String location = "/account";

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const AccountPage(),
      );
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
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
                  t.labelAccount,
                  style: theme.textTheme.displayLarge,
                ),
              ),
              Wrap(
                direction: Breakpoints.small.isActive(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: Paddings.small,
                spacing: Paddings.small,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSecondaryContainer,
                      backgroundColor: theme.colorScheme.secondaryContainer,
                    ).copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                    onPressed: () => unawaited(
                      context.read<UserController>().logout(),
                    ),
                    icon: const Icon(Icons.logout_outlined),
                    label: Text(
                      t.logOut,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: theme.colorScheme.onErrorContainer,
                      backgroundColor: theme.colorScheme.errorContainer,
                    ).copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                    onPressed: () => unawaited(
                      context.read<UserController>().deleteAccout(),
                    ),
                    icon: const Icon(Icons.no_accounts_outlined),
                    label: Text(
                      t.deleteAccount,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
