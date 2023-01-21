import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

/// An icon for use in "toggle dark mode" buttons.
class ThemeModeIcon extends StatelessWidget {
  const ThemeModeIcon({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Icon(
      size: size,
      theme.brightness == Brightness.light
          ? Icons.dark_mode_outlined
          : Icons.light_mode_outlined,
      semanticLabel: t.semanticsToggleThemeMode,
    );
  }
}
