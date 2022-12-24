import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/theme/theme.dart";
import "package:portal/components/dansdata_logo.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    required this.themeMode,
    required this.locale,
  });

  final ThemeMode themeMode;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dansdata Portal",
      themeMode: themeMode,
      theme: dansdataThemeLight,
      darkTheme: dansdataThemeDark,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        final theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.colorScheme.background,
          body: Align(
            child: DansdataLogo(
              logoSize: 128,
              textSize: theme.textTheme.headlineMedium?.fontSize,
              taglineSize: theme.textTheme.labelSmall?.fontSize,
              direction: Axis.vertical,
              border: theme.brightness == Brightness.light,
            ),
          ),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
