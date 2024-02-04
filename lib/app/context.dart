import "package:flutter/material.dart";
import "package:injectable/injectable.dart";
import "package:signals/signals_flutter.dart";

@singleton
@injectable
class ApplicationContext {
  final Signal<String> appTitle = signal("Dansdata Portal");
  final Signal<ThemeMode> appTheme = signal(ThemeMode.system);
  final Signal<double> contentHeight = signal(0.0);
  final Signal<double> contentWidth = signal(0.0);
}
