import 'package:flutter/material.dart';

class AppTheme {
  // Paleta de colores de DentalFlow
  static const Color primario = Color(0xFF5BBCB4);
  static const Color secundario = Color(0xFFF5EDD8);
  static const Color textoPrincipal = Color(0xFF1a1a2e);
  static const Color textoSecundario = Color(0xFF6b7280);
  static const Color fondoInput = Color(0xFFf9fafb);
  static const Color bordeInput = Color(0xFFe5e7eb);
  static const Color fondo = Color(0xFFFFFFFF);

  static ThemeData get tema {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: fondo,

      // Color principal de la app
      colorScheme: ColorScheme.fromSeed(
        seedColor: primario,
        primary: primario,
        secondary: secundario,
        surface: fondo,
      ),

      // Estilo de los campos de texto
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fondoInput,
        labelStyle: const TextStyle(color: textoSecundario),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: bordeInput),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: bordeInput),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primario, width: 2),
        ),
      ),

      // Estilo del botón principal
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primario,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Estilo del texto general
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textoPrincipal),
        bodyMedium: TextStyle(color: textoSecundario),
      ),
    );
  }
}
