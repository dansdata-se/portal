import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/app/theme/theme.dart";
import "package:portal/widgets/dansdata_logo.dart";
import "package:provider/provider.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dansdata Portal",
      themeMode: context.watch<ThemeModeSetting>().value,
      theme: dansdataThemeLight,
      darkTheme: dansdataThemeDark,
      locale: context.watch<LanguageSetting>().locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.colorScheme.background,
          body: Align(
            child: DansdataLogo(
              logoSize: 128,
              direction: Axis.vertical,
              border: theme.brightness == Brightness.light,
            ),
          ),
        );
      },
    );
  }
}
