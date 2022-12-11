import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

const brandTextStyle = GoogleFonts.norican;
const plainTextStyle = GoogleFonts.robotoFlex;

TextTheme textTheme(TextTheme theme) =>
    GoogleFonts.robotoFlexTextTheme(theme).copyWith(
      displayLarge: brandTextStyle(textStyle: theme.displayLarge, fontSize: 64),
      displayMedium: brandTextStyle(textStyle: theme.displayMedium),
      displaySmall: brandTextStyle(textStyle: theme.displaySmall),
      headlineLarge: brandTextStyle(textStyle: theme.headlineLarge),
      headlineMedium: brandTextStyle(textStyle: theme.headlineMedium),
      headlineSmall: brandTextStyle(textStyle: theme.headlineSmall),
      titleLarge: brandTextStyle(textStyle: theme.titleLarge),
    );
