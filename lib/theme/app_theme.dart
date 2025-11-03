import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF3B82F6));
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
        titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ).copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: colorScheme.secondaryContainer,
        backgroundColor: Colors.transparent,
        elevation: 0,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w600, color: colorScheme.onSurface),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 14, height: 1.4),
      ),
    );
  }
}


