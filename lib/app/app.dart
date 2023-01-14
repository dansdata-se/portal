import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/routing/portal_router.dart";
import "package:portal/app/state/page_title_state.dart";
import "package:portal/app/state/settings/language_setting.dart";
import "package:portal/app/state/settings/theme_mode_setting.dart";
import "package:portal/app/theme/color_schemes.dart";
import "package:portal/app/theme/theme.dart";
import "package:provider/provider.dart";

final _routerConfig = buildRouterConfig();

class DansdataPortalApp extends StatelessWidget {
  const DansdataPortalApp({super.key, this.routerConfig});

  final RouterConfig<Object>? routerConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: context.watch<PageTitleState>().value,
      themeMode: context.watch<ThemeModeSetting>().value,
      theme: dansdataThemeLight,
      darkTheme: dansdataThemeDark,
      color: context.watch<ThemeModeSetting>().isDarkTheme
          ? darkColorScheme.background
          : lightColorScheme.primary,
      routerConfig: routerConfig ?? _routerConfig,
      locale: context.watch<LanguageSetting>().locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
