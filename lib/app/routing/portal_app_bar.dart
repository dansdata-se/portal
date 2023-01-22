import "package:flutter/material.dart";
import "package:portal/app/theme/theme_mode_click_handler.dart";
import "package:portal/app/theme/theme_mode_icon.dart";
import "package:portal/l10n/flag_icon.dart";
import "package:portal/l10n/language_click_handler.dart";
import "package:portal/widgets/dansdata_logo.dart";

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
          onPressed: () =>
              const ThemeModeClickHandlerDelegate().onToggleThemeClick(context),
          icon: const ThemeModeIcon(),
        ),
        IconButton(
          key: PortalAppBar.languageToggleKey,
          onPressed: () => const LanguageClickHandlerDelegate()
              .onToggleLanguageClick(context),
          icon: const FlagIcon(size: 24),
        ),
      ];
}
