import "package:flutter/material.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/app/theme/theme_mode_click_handler.dart";
import "package:portal/app/theme/theme_mode_icon.dart";
import "package:portal/l10n/flag_icon.dart";
import "package:portal/l10n/language_click_handler.dart";

/// Trailing widget for [PortalNavigationDrawer] and [PortalNavigationRail]
class RailDrawerTrailing extends StatelessWidget
    with ThemeModeClickHandler, LanguageClickHandler {
  static const Key themeModeToggleKey = Key("railDrawerTrailing.themeMode");
  static const Key languageToggleKey = Key("railDrawerTrailing.language");

  const RailDrawerTrailing({super.key});

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
