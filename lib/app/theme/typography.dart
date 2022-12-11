import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

TextTheme textTheme(TextTheme theme) =>
    GoogleFonts.robotoFlexTextTheme(theme).copyWith(
      displayLarge: GoogleFonts.norican(textStyle: theme.displayLarge),
      displayMedium: GoogleFonts.norican(textStyle: theme.displayMedium),
      displaySmall: GoogleFonts.norican(textStyle: theme.displaySmall),
      headlineLarge: GoogleFonts.norican(textStyle: theme.headlineLarge),
      headlineMedium: GoogleFonts.norican(textStyle: theme.headlineMedium),
      headlineSmall: GoogleFonts.norican(textStyle: theme.headlineSmall),
      titleLarge: GoogleFonts.norican(textStyle: theme.titleLarge),
    );
