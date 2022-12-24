import "package:flutter/material.dart";
import "package:kotlin_scope_function/kotlin_scope_function.dart";
import "package:portal/app/theme/color_schemes.dart";
import "package:portal/app/theme/typography.dart";

final dansdataThemeLight = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
).let(
  (it) => it.copyWith(textTheme: textTheme(it.textTheme)),
);
final dansdataThemeDark = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
).let(
  (it) => it.copyWith(textTheme: textTheme(it.textTheme)),
);
