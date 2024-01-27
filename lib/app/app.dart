import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/l10n/localization_service.dart";
import "package:dansdata_portal/app/routing/navigation_service.dart";
import "package:dansdata_portal/app/theme/theme.dart";
import "package:dansdata_portal/dependency_injection/inject.dart";
import "package:flutter/material.dart";
import "package:signals/signals_flutter.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appContext = context.inject<ApplicationContext>();
    final localizationService = context.inject<LocalizationService>();
    final navigationService = context.inject<NavigationService>();
    return MaterialApp.router(
      title: watchSignal(context, appContext.appTitle),
      theme: dansdataThemeLight,
      darkTheme: dansdataThemeDark,
      themeMode: watchSignal(context, appContext.appTheme),
      localizationsDelegates: LocalizationService.localizationsDelegates,
      supportedLocales: LocalizationService.supportedLocales,
      locale: watchSignal(context, localizationService.locale),
      routerConfig: watchSignal(context, navigationService.router),
    );
  }
}
