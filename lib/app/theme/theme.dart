import "package:dansdata_portal/app/theme/color_schemes.dart";
import "package:dansdata_portal/app/theme/typography.dart";
import "package:flutter/material.dart";

final _dansdataLightColorTheme = ThemeData(
  useMaterial3: true,
  colorScheme: dansdataLightColorScheme,
  fontFamily: fontFamilyDefault,
);
final dansdataThemeLight = _dansdataLightColorTheme.copyWith(
  textTheme: dansdataTextTheme(_dansdataLightColorTheme.textTheme),
);

final _dansdataDarkColorTheme = ThemeData(
  useMaterial3: true,
  colorScheme: dansdataDarkColorScheme,
  fontFamily: fontFamilyDefault,
);
final dansdataThemeDark = _dansdataDarkColorTheme.copyWith(
  textTheme: dansdataTextTheme(_dansdataDarkColorTheme.textTheme),
);
