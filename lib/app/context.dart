import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:logger/logger.dart";
import "package:signals/signals_flutter.dart";

class ApplicationContext {
  ApplicationContext({required Logger logger}) {
    _logger = logger;
  }

  late final Logger _logger;

  final Signal<String> appTitle = signal("Dansdata Portal");
  final Signal<ThemeMode> appTheme = signal(ThemeMode.system);
  final Signal<double> contentHeight = signal(0.0);
  final Signal<double> contentWidth = signal(0.0);

  bool _l10nInitialized = false;
  late final Signal<AppLocalizations> l10n;

  void onAppBuild(BuildContext context) {
    if (_l10nInitialized) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        l10n.value = AppLocalizations.of(context)!;
      });
    } else {
      _logger.d("Initializing ${(ApplicationContext).toString()}");
      _l10nInitialized = true;
      l10n = signal(AppLocalizations.of(context)!);
    }
  }
}
