import "dart:async";

import "package:flutter/material.dart";
import "package:portal/app/settings/flag_icon.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_icon.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/app/theme/radii.dart";
import "package:portal/components/dansdata_logo.dart";
import "package:portal/components/portal_app_bar.dart";
import "package:portal/gen/assets.gen.dart";
import "package:provider/provider.dart";

class AuthLayout extends StatefulWidget {
  const AuthLayout({super.key, required this.builder});

  final Widget Function(BuildContext context, bool useSmallLayout) builder;

  @override
  State<StatefulWidget> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  late Image _backgroundImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final theme = Theme.of(context);

    _backgroundImage = Image.asset(
      Assets.images.loginBackground.keyName,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.primaryContainer,
      colorBlendMode: BlendMode.color,
      excludeFromSemantics: true,
      isAntiAlias: false,
    );
    unawaited(
      precacheImage(_backgroundImage.image, context),
    );
  }

  void onToggleThemeMode() {
    final theme = Theme.of(context);
    unawaited(
      context.read<ThemeModeSetting>().update(
            theme.brightness == Brightness.light
                ? ThemeMode.dark
                : ThemeMode.light,
          ),
    );
  }

  void onToggleLanguage() {
    unawaited(context.read<LanguageSetting>().toggle());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final useSmallLayout = mediaQuery.size.width < 500;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      // Remove focus when clicking outside text fields
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            _backgroundImage,
            if (useSmallLayout)
              Container(
                color: theme.colorScheme.background.withAlpha(200),
              ),
            useSmallLayout ? _smallLayout(context) : _largeLayout(context),
          ],
        ),
      ),
      floatingActionButton: useSmallLayout ? null : _largeLayoutFabs(context),
    );
  }

  Widget _smallLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        alignment: Alignment.topCenter,
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PortalAppBar.of(context),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: Container(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: widget.builder(context, true),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _largeLayout(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Paddings.large),
        child: Container(
          alignment: Alignment.center,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: theme.colorScheme.outline),
              borderRadius: const BorderRadius.all(Radius.circular(Radii.card)),
            ),
            child: IntrinsicWidth(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Paddings.extraLarge),
                    child: DansdataLogo(
                      logoSize: theme.textTheme.displayLarge!.fontSize,
                      textSize: theme.textTheme.displayMedium!.fontSize,
                      border: theme.brightness == Brightness.light,
                    ),
                  ),
                  widget.builder(context, false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _largeLayoutFabs(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.small(
          key: PortalAppBar.themeModeToggleKey,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.primary,
          onPressed: onToggleThemeMode,
          child: const ThemeModeIcon(),
        ),
        const SizedBox(height: Paddings.large),
        FloatingActionButton.small(
          key: PortalAppBar.languageToggleKey,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.primary,
          onPressed: onToggleLanguage,
          child: const FlagIcon(size: 24),
        ),
      ],
    );
  }
}
