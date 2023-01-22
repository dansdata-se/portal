import "dart:async";

import "package:flutter/material.dart";
import "package:portal/app/state/settings/language_setting.dart";
import "package:portal/app/state/settings/theme_mode_setting.dart";
import "package:portal/app/theme/theme_mode_icon.dart";
import "package:portal/l10n/flag_icon.dart";
import "package:portal/widgets/dansdata_logo.dart";
import "package:provider/provider.dart";

class PortalAppBar extends AppBar {
  static const Key languageToggleKey = Key("portalAppBar.language");
  static const Key themeModeToggleKey = Key("portalAppBar.themeMode");

  PortalAppBar._({super.key, super.title, super.actions});

  factory PortalAppBar.of(BuildContext context, {Key? key}) {
    final theme = Theme.of(context);
    return PortalAppBar._(
      key: key,
      title: DansdataLogo(
        logoSize: 30,
        titleStyle:
            theme.textTheme.titleLarge!.copyWith(color: Colors.transparent),
        taglineStyle: null,
        wrap: false,
        border: theme.brightness == Brightness.light,
      ),
      actions: _actions(context),
    );
  }

  static List<Widget> _actions(BuildContext context) => [
        IconButton(
          key: PortalAppBar.themeModeToggleKey,
          onPressed: () => _onToggleThemeMode(context),
          icon: const ThemeModeIcon(),
        ),
        IconButton(
          key: PortalAppBar.languageToggleKey,
          onPressed: () => _onToggleLanguage(context),
          icon: const FlagIcon(size: 24),
        ),
      ];

  static void _onToggleThemeMode(BuildContext context) {
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
}
