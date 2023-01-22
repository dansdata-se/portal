import "dart:async";

import "package:flutter/material.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/app/theme/theme_mode_icon.dart";
import "package:portal/app/theme/theme_mode_setting.dart";
import "package:portal/l10n/flag_icon.dart";
import "package:portal/l10n/language_setting.dart";
import "package:provider/provider.dart";

/// Trailing widget for [PortalNavigationDrawer] and [PortalNavigationRail]
class RailDrawerTrailing extends StatelessWidget {
  static const Key themeModeToggleKey = Key("railDrawerTrailing.themeMode");
  static const Key languageToggleKey = Key("railDrawerTrailing.language");

  const RailDrawerTrailing({super.key});

  void _onToggleThemeMode(BuildContext context) {
    final theme = Theme.of(context);
    unawaited(
      context.read<ThemeModeSetting>().update(
            theme.brightness == Brightness.light
                ? ThemeMode.dark
                : ThemeMode.light,
          ),
    );
  }

  static void _onToggleLanguage(BuildContext context) {
    unawaited(context.read<LanguageSetting>().toggle());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            top: Paddings.extraExtraLarge,
            bottom: Paddings.large,
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: Paddings.medium,
            children: [
              OutlinedButton(
                key: themeModeToggleKey,
                onPressed: () => _onToggleThemeMode(context),
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  fixedSize: const Size.square(40),
                  foregroundColor: theme.colorScheme.onSurfaceVariant,
                ),
                child: const ThemeModeIcon(size: 18),
              ),
              OutlinedButton(
                key: languageToggleKey,
                onPressed: () => _onToggleLanguage(context),
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  fixedSize: const Size.square(40),
                ),
                child: const FlagIcon(size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
