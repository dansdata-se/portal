import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/auth/auth_controller.dart";
import "package:portal/app/auth/logout_click_handler.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/app/theme/theme_mode_click_handler.dart";
import "package:portal/app/theme/theme_mode_icon.dart";
import "package:portal/l10n/flag_icon.dart";
import "package:portal/l10n/language_click_handler.dart";
import "package:provider/provider.dart";

/// Trailing widget for [PortalNavigationDrawer] and [PortalNavigationRail]
class RailDrawerTrailing extends StatelessWidget
    with ThemeModeClickHandler, LanguageClickHandler, LogoutClickHandler {
  static const Key themeModeToggleKey = Key("railDrawerTrailing.themeMode");
  static const Key languageToggleKey = Key("railDrawerTrailing.language");
  static const Key logoutButtonKey = Key("railDrawerTrailing.logout");

  const RailDrawerTrailing({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: Paddings.medium,
      children: [
        OutlinedButton(
          key: themeModeToggleKey,
          onPressed: () => onToggleThemeClick(context),
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const Size.square(40),
            foregroundColor: theme.colorScheme.onSurfaceVariant,
          ),
          child: const ThemeModeIcon(size: 18),
        ),
        OutlinedButton(
          key: languageToggleKey,
          onPressed: () => onToggleLanguageClick(context),
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const Size.square(40),
          ),
          child: const FlagIcon(size: 18),
        ),
        OutlinedButton(
          key: logoutButtonKey,
          onPressed: context.watch<AuthController>().isLoggingOut
              ? null
              : () => onLogoutClick(context),
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            fixedSize: const Size.square(40),
            foregroundColor: theme.colorScheme.onSurfaceVariant,
          ),
          child: context.watch<AuthController>().isLoggingOut
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.onSurfaceVariant,
                    strokeWidth: 2,
                  ),
                )
              : Icon(
                  Icons.logout_outlined,
                  semanticLabel: t.semanticsLogOut,
                  size: 18,
                ),
        ),
      ],
    );
  }
}
