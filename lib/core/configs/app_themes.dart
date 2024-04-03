import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData lightBaseTheme = ThemeData.light(useMaterial3: false);

  static ThemeData lightTheme = lightBaseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(),
    /*
    primaryColorDark: const Color(0xFF0097A7),
    primaryColorLight: const Color(0xFFB2EBF2),
    primaryColor: const Color(0xFF00BCD4),
    colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
    scaffoldBackgroundColor: const Color(0xFFE0F2F1),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    */
  );

  static ThemeData darkBaseTheme = ThemeData.dark(useMaterial3: false);

  static ThemeData darkTheme = darkBaseTheme.copyWith(
    textTheme: TextTheme(
      displayLarge:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.displayLarge),
      displayMedium:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.displayMedium),
      displaySmall:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.displaySmall),
      headlineLarge:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.headlineLarge),
      headlineMedium:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.headlineMedium),
      headlineSmall:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.headlineSmall),
      titleLarge:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.titleLarge),
      titleMedium:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.titleMedium),
      titleSmall:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.titleSmall),
      bodyLarge: GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.bodyLarge),
      bodyMedium:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.bodyMedium),
      bodySmall: GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.bodySmall),
      labelLarge:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.labelLarge),
      labelMedium:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.labelMedium),
      labelSmall:
          GoogleFonts.lato(textStyle: darkBaseTheme.textTheme.labelSmall),
    ),
    /*
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    */
  );

  static ThemeData lightDevTheme = lightTheme.copyWith(
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      );

  static ThemeData darkDevTheme = darkTheme.copyWith(
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      );
}
