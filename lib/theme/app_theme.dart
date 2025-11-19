import 'package:flutter/material.dart';

class AppTheme {
  // Modern, vibrant color palette
  static const Color _primaryBlue = Color(0xFF2563EB); // Vivid blue
  static const Color _accentPurple = Color(0xFF8B5CF6); // Modern purple
  
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryBlue,
      secondary: _accentPurple,
      brightness: Brightness.light,
    ).copyWith(
      primary: _primaryBlue,
      primaryContainer: const Color(0xFFDEEAFF),
      secondary: _accentPurple,
      secondaryContainer: const Color(0xFFF3EDFF),
      tertiary: const Color(0xFF10B981), // Success green
      tertiaryContainer: const Color(0xFFD1FAE5),
      surface: Colors.white,
      error: const Color(0xFFEF4444),
      errorContainer: const Color(0xFFFEE2E2),
      onSurface: const Color(0xFF1F2937),
      shadow: Colors.black,
    );
    
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      
      // Modern AppBar styling
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      
      // Enhanced card styling
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outlineVariant.withOpacity(0.3),
            width: 1,
          ),
        ),
        color: colorScheme.surface,
        shadowColor: colorScheme.shadow.withOpacity(0.05),
      ),
      
      // Modern navigation bar
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: colorScheme.primaryContainer,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            );
          }
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface.withOpacity(0.6),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              size: 26,
              color: colorScheme.primary,
            );
          }
          return IconThemeData(
            size: 24,
            color: colorScheme.onSurface.withOpacity(0.6),
          );
        }),
      ),
      
      // Enhanced typography
      textTheme: TextTheme(
        // Headings
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          letterSpacing: -0.3,
          height: 1.3,
        ),
        
        // Titles
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          height: 1.3,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
        
        // Body text
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface.withOpacity(0.7),
          height: 1.5,
        ),
        
        // Labels
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface.withOpacity(0.8),
        ),
      ),
      
      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: colorScheme.outline),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
      
      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primaryContainer,
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      
      // Divider theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withOpacity(0.3),
        thickness: 1,
        space: 1,
      ),
      
      // Icon theme
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: 24,
      ),
    );
  }
}