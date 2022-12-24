import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/auth/account_provider.dart";
import "package:portal/app/auth/user_controller.dart";
import "package:portal/gen/assets.gen.dart";
import "package:portal/sso/facebook_brand.dart";
import "package:portal/sso/github_brand.dart";
import "package:portal/sso/google_brand.dart";
import "package:provider/provider.dart";

abstract class SsoButton extends StatelessWidget {
  static const _iconSize = 18.0;

  const SsoButton({
    super.key,
    required this.accountProvider,
  });

  final AccountProvider accountProvider;

  Widget buildButton(
    BuildContext context, {
    required Color foregroundColor,
    required Color backgroundColor,
    required Widget icon,
    BorderSide? borderSide,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
        ).copyWith(
          elevation: ButtonStyleButton.allOrNull(0.0),
          shape: borderSide == null
              ? null
              : MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: borderSide,
                  ),
                ),
        ),
        onPressed: () => unawaited(
          context.read<UserController>().loginWithProvider(accountProvider),
        ),
        icon: icon,
        label: Text(
          AppLocalizations.of(context)!.loginWithProvider(accountProvider.name),
        ),
      );
}

class FacebookSsoButton extends SsoButton {
  const FacebookSsoButton({super.key})
      : super(accountProvider: AccountProvider.facebook);

  @override
  Widget build(BuildContext context) => buildButton(
        context,
        foregroundColor: FacebookBrand.foregroundColor,
        backgroundColor: FacebookBrand.backgroundColor,
        icon: Assets.images.sso.facebook.image(height: SsoButton._iconSize),
      );
}

class GithubSsoButton extends SsoButton {
  const GithubSsoButton({super.key})
      : super(accountProvider: AccountProvider.github);

  @override
  Widget build(BuildContext context) => buildButton(
        context,
        foregroundColor: GithubBrand.foregroundColor,
        backgroundColor: GithubBrand.backgroundColor,
        icon: Assets.images.sso.github.svg(
          height: SsoButton._iconSize,
          color: GithubBrand.foregroundColor,
        ),
      );
}

class GoogleSsoButton extends SsoButton {
  const GoogleSsoButton({super.key})
      : super(accountProvider: AccountProvider.google);

  @override
  Widget build(BuildContext context) => buildButton(
        context,
        foregroundColor: GoogleBrand.foregroundColor,
        backgroundColor: GoogleBrand.backgroundColor,
        icon: Assets.images.sso.google.svg(
          height: SsoButton._iconSize,
        ),
        borderSide: Theme.of(context).brightness == Brightness.light
            ? const BorderSide(
                color: GoogleBrand.foregroundColor,
              )
            : null,
      );
}
