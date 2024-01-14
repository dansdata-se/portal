import "package:flutter/material.dart";

const fontFamilyBrand = "Norican";
const fontFamilyDefault = "RobotoFlex";

TextTheme dansdataTextTheme(TextTheme theme) => TextTheme(
      displayLarge: theme.displayLarge?.copyWith(
        fontFamily: fontFamilyBrand,
      ),
      displayMedium: theme.displayMedium?.copyWith(
        fontFamily: fontFamilyBrand,
      ),
      displaySmall: theme.displaySmall?.copyWith(
        fontFamily: fontFamilyBrand,
      ),
      headlineLarge: theme.headlineLarge?.copyWith(
        fontFamily: fontFamilyBrand,
      ),
      headlineMedium: theme.headlineMedium?.copyWith(
        fontFamily: fontFamilyBrand,
      ),
      headlineSmall: theme.headlineSmall?.copyWith(
        fontFamily: fontFamilyBrand,
      ),
      titleLarge: theme.titleLarge?.copyWith(
        fontFamily: fontFamilyDefault,
      ),
      titleMedium: theme.titleMedium?.copyWith(
        fontFamily: fontFamilyDefault,
      ),
      titleSmall: theme.titleSmall?.copyWith(
        fontFamily: fontFamilyDefault,
      ),
      bodyLarge: theme.bodyLarge?.copyWith(
        fontFamily: fontFamilyDefault,
      ),
      bodyMedium: theme.bodyMedium?.copyWith(
        fontFamily: fontFamilyDefault,
      ),
      bodySmall: theme.bodySmall?.copyWith(
        fontFamily: fontFamilyDefault,
      ),
      labelLarge: theme.labelLarge?.copyWith(
        fontFamily: fontFamilyDefault,
      ),
      labelMedium: theme.labelMedium?.copyWith(
        fontFamily: fontFamilyDefault,
      ),
      labelSmall: theme.labelSmall?.copyWith(
        fontFamily: fontFamilyDefault,
      ),
    );
