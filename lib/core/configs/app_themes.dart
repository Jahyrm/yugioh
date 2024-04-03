import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Aquí podríamos editar y configurar los temas claro y oscuro de la app
class AppThemes {
  static ThemeData lightBaseTheme = ThemeData.light(useMaterial3: false);

  /// Modificar aquí
  static ThemeData lightTheme = lightBaseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(),
  );

  static ThemeData darkBaseTheme = ThemeData.dark(useMaterial3: false);

  /// Modificar aquí
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
  );

  static ThemeData lightDevTheme = lightTheme.copyWith(
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      );

  static ThemeData darkDevTheme = darkTheme.copyWith(
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      );
}
