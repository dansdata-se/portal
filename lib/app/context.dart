import "package:dansdata_portal/app/router.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:signals/signals_flutter.dart";

class ApplicationContext {
  ApplicationContext({required this.injector});

  final GetIt injector;
  final Signal<GoRouter> router = signal(mainRouter);
  final Signal<String> appTitle = signal("Dansdata Portal");
  final Signal<ThemeMode> appTheme = signal(ThemeMode.system);
  final Signal<double> contentHeight = signal(0.0);
  final Signal<double> contentWidth = signal(0.0);
}
