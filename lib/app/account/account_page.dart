import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/routing/page.dart";

class AccountDestination extends DestinationWithoutParams {
  const AccountDestination();

  @override
  final String location = "/account";

  @override
  String getLabel(AppLocalizations t) => t.labelAccount;

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const AccountPage(),
      );
}

class AccountPage extends StatelessPage {
  static const Key pageKey = Key("accountPage.pageKey");

  const AccountPage({super.key})
      : super(destination: const AccountDestination());

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      key: pageKey,
      color: theme.colorScheme.background,
      child: Text(
        t.labelAccount,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}
