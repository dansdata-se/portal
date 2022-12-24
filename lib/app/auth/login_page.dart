import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/auth/auth_layout.dart";
import "package:portal/app/auth/login_form.dart";
import "package:portal/app/auth/sso_button.dart";
import "package:portal/app/navigation/destination.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/components/divider_with_text_widget.dart";
import "package:styled_text/styled_text.dart";
import "package:url_launcher/url_launcher.dart";

class LoginDestination extends DestinationWithoutParams {
  const LoginDestination();

  @override
  final String location = "/login";

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const LoginPage(),
      );
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      builder: (context, useSmallLayout) {
        final t = AppLocalizations.of(context)!;
        final horizontalPadding =
            useSmallLayout ? Paddings.medium : Paddings.extraLarge;
        return Column(
          mainAxisAlignment: useSmallLayout
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          mainAxisSize: useSmallLayout ? MainAxisSize.max : MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Used to add top spacing on mobile
            if (useSmallLayout) const SizedBox(height: Paddings.medium),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: _ssoButtons(context),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                top: Paddings.extraLarge,
              ),
              child: DividerWithText(text: t.or),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    top: Paddings.extraLarge,
                  ),
                  child: _formWithNavigation(context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: useSmallLayout ? Paddings.small : Paddings.large,
                  ),
                  child: const Divider(),
                ),
                SizedBox(
                  width: 0,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: horizontalPadding,
                      right: horizontalPadding,
                      top: useSmallLayout ? Paddings.small : Paddings.large,
                      bottom: Paddings.extraLarge,
                    ),
                    child: _tosDisclaimer(context),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _formWithNavigation(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LoginForm(),
        const SizedBox(height: Paddings.small),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            // todo(FelixZY): Navigate to reset password
            TextButton(
              onPressed: () => {},
              child: Text(t.resetPassword),
            ),
            // todo(FelixZY): Navigate to create account
            TextButton(
              onPressed: () => {},
              child: Text(t.createAccount),
            ),
          ],
        ),
      ],
    );
  }

  Widget _ssoButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        FacebookSsoButton(),
        SizedBox(height: Paddings.small),
        GithubSsoButton(),
        SizedBox(height: Paddings.small),
        GoogleSsoButton(),
      ],
    );
  }

  Widget _tosDisclaimer(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return StyledText(
      textAlign: TextAlign.center,
      text: t.tosDisclaimer,
      style: theme.textTheme.bodySmall!,
      tags: {
        "tos": StyledTextActionTag(
          (text, attributes) => unawaited(
            // todo(FelixZY): Navigate to internal page
            launchUrl(
              Uri.parse(
                "https://portal.staging.dansdata.se/legal/terms-of-service/",
              ),
            ),
          ),
          style: theme.textTheme.bodySmall!
              .copyWith(color: theme.colorScheme.primary),
        ),
        "privacy": StyledTextActionTag(
          (text, attributes) => unawaited(
            // todo(FelixZY): Navigate to internal page
            launchUrl(
              Uri.parse(
                "https://portal.staging.dansdata.se/legal/privacy/",
              ),
            ),
          ),
          style: theme.textTheme.bodySmall!
              .copyWith(color: theme.colorScheme.primary),
        ),
      },
    );
  }
}
