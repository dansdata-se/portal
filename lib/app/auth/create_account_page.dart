import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/routing/page.dart";

class CreateAccountDestination extends DestinationWithoutParams {
  const CreateAccountDestination();

  @override
  final String location = "/createAccount";

  @override
  String getLabel(AppLocalizations t) => t.labelCreateAccount;

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const CreateAccountPage(),
      );
}

class CreateAccountPage extends StatelessPage {
  static const Key pageKey = Key("createAccountPage.pageKey");

  const CreateAccountPage({super.key})
      : super(destination: const CreateAccountDestination());

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      key: pageKey,
      color: theme.colorScheme.background,
      child: Text(
        t.labelCreateAccount,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}
