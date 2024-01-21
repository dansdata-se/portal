import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/theme/theme.dart";
import "package:dansdata_portal/dependency_injection/inject.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:signals/signals_flutter.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appContext = inject<ApplicationContext>(context);
    return MaterialApp.router(
      title: watchSignal(context, appContext.appTitle),
      theme: dansdataThemeLight,
      darkTheme: dansdataThemeDark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: watchSignal(context, appContext.appTheme),
      routerConfig: watchSignal(context, appContext.router),
      builder: (context, child) {
        appContext.onAppBuild(context);
        return child ?? Container();
      },
    );
  }
}
