import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/routing/page.dart";

class ResetPasswordDestination extends DestinationWithoutParams {
  const ResetPasswordDestination();

  @override
  final String location = "/resetPassword";

  @override
  String getLabel(AppLocalizations t) => t.labelResetPassword;

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const ResetPasswordPage(),
      );
}

class ResetPasswordPage extends StatelessPage {
  static const Key pageKey = Key("resetPasswordPage.pageKey");

  const ResetPasswordPage({super.key})
      : super(destination: const ResetPasswordDestination());

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      key: pageKey,
      color: theme.colorScheme.background,
      child: Text(
        t.labelResetPassword,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}
