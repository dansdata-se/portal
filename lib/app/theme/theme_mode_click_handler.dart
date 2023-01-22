import "dart:async";

import "package:flutter/material.dart";
import "package:portal/app/theme/theme_mode_setting.dart";
import "package:provider/provider.dart";

/// Helper mixin for widgets, providing a standardized [onToggleThemeClick]
/// method.
mixin ThemeModeClickHandler {
  void onToggleThemeClick(BuildContext context) {
    final theme = Theme.of(context);
    unawaited(
      context.read<ThemeModeSetting>().update(
            theme.brightness == Brightness.light
                ? ThemeMode.dark
                : ThemeMode.light,
          ),
    );
  }
}

class ThemeModeClickHandlerDelegate with ThemeModeClickHandler {
  const ThemeModeClickHandlerDelegate();
}
