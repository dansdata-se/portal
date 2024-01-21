import "package:dansdata_portal/app/router.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:logger/logger.dart";
import "package:signals/signals_flutter.dart";

class ApplicationContext {
  ApplicationContext({required this.injector});

  final GetIt injector;
  late final Logger _logger = injector.get();

  final Signal<GoRouter> router = signal(mainRouter);
  final Signal<String> appTitle = signal("Dansdata Portal");
  final Signal<ThemeMode> appTheme = signal(ThemeMode.system);
  final Signal<double> contentHeight = signal(0.0);
  final Signal<double> contentWidth = signal(0.0);

  bool _initialized = false;
  late final Signal<AppLocalizations> l10n;

  void onAppBuild(BuildContext context) {
    if (_initialized) {
      l10n.value = AppLocalizations.of(context)!;
    } else {
      _logger.d("Initializing ${(ApplicationContext).toString()}");
      _initialized = true;
      l10n = signal(AppLocalizations.of(context)!);
    }
  }
}
