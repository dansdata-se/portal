import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/auth/layout/auth_layout.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/routing/page.dart";

class LoginDestination extends DestinationWithoutParams {
  const LoginDestination();

  @override
  final String location = "/login";

  @override
  String getLabel(AppLocalizations t) => t.labelLogin;

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const LoginPage(),
      );
}

class LoginPage extends StatelessPage {
  static const Key pageKey = Key("loginPage.pageKey");

  const LoginPage({super.key}) : super(destination: const LoginDestination());

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AuthLayout(
      key: pageKey,
      child: Text(
        t.labelLogin,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}
