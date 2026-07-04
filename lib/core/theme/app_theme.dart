import 'package:flutter/material.dart';

// ── Theme Controller ──────────────────────────────────────────────

final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.dark);

extension ThemeNotifierToggle on ValueNotifier<ThemeMode> {
  void toggle() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

// ── Colors ────────────────────────────────────────────────────────

abstract final class AppColors {
  AppColors._();

  static const lightPrimary = Color(0xFF7C3AED);
  static const lightOnPrimary = Colors.white;
  static const lightSecondary = Color(0xFFD946EF);
  static const lightOnSecondary = Colors.white;
  static const lightTertiary = Color(0xFFFF6B5F);
  static const lightOnTertiary = Colors.white;
  static const lightBackground = Color(0xFFF7F8FC);
  static const lightSurface = Colors.white;
  static const lightOnSurface = Color(0xFF111827);
  static const lightOnSurfaceVariant = Color(0xFF6B7280);
  static const lightOutline = Color(0xFFE5E7EB);
  static const lightSurfaceContainerHighest = Color(0xFFEEEEF2);
  static const lightSurfaceContainerHigh = Color(0xFFF3F3F7);
  static const lightSurfaceContainer = Color(0xFFF7F7FA);
  static const lightSurfaceContainerLow = Color(0xFFFBFBFC);
  static const lightSurfaceDim = Color(0xFFE6E6EC);
  static const lightPrimaryContainer = Color(0xFFEDE9FE);
  static const lightOnPrimaryContainer = Color(0xFF4C1D95);
  static const lightSecondaryContainer = Color(0xFFF5D0FE);
  static const lightOnSecondaryContainer = Color(0xFF86198F);
  static const lightTertiaryContainer = Color(0xFFFFD6D2);
  static const lightOnTertiaryContainer = Color(0xFF9B1D1A);
  static const lightOutlineVariant = Color(0xFFD1D5DB);
  static const lightError = Color(0xFFEF4444);

  static const darkPrimary = Color(0xFF8B5CF6);
  static const darkOnPrimary = Colors.white;
  static const darkSecondary = Color(0xFFE056FD);
  static const darkOnSecondary = Colors.white;
  static const darkTertiary = Color(0xFFFF7A59);
  static const darkOnTertiary = Color(0xFF1E1B4B);
  static const darkBackground = Color(0xFF0F172A);
  static const darkSurface = Color(0xFF1E293B);
  static const darkOnSurface = Colors.white;
  static const darkOnSurfaceVariant = Color(0xFFCBD5E1);
  static const darkOutline = Color(0xFF334155);
  static const darkSurfaceContainerHighest = Color(0xFF334155);
  static const darkSurfaceContainerHigh = Color(0xFF263348);
  static const darkSurfaceContainer = Color(0xFF1E293B);
  static const darkSurfaceContainerLow = Color(0xFF1A2332);
  static const darkSurfaceDim = Color(0xFF0F172A);
  static const darkSurfaceBright = Color(0xFF334155);
  static const darkPrimaryContainer = Color(0xFF4C1D95);
  static const darkOnPrimaryContainer = Color(0xFFEDE9FE);
  static const darkSecondaryContainer = Color(0xFF86198F);
  static const darkOnSecondaryContainer = Color(0xFFF5D0FE);
  static const darkTertiaryContainer = Color(0xFF9B1D1A);
  static const darkOnTertiaryContainer = Color(0xFFFFD6D2);
  static const darkOutlineVariant = Color(0xFF475569);
  static const darkError = Color(0xFFEF4444);

  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7C3AED),
      Color(0xFFA855F7),
      Color(0xFFD946EF),
      Color(0xFFFF6B5F),
    ],
  );

  static const darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6D28D9),
      Color(0xFF9333EA),
      Color(0xFFC026D3),
      Color(0xFFE94E3C),
    ],
  );
}

// ── Theme Data ────────────────────────────────────────────────────

abstract final class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const cs = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      primaryContainer: AppColors.lightPrimaryContainer,
      onPrimaryContainer: AppColors.lightOnPrimaryContainer,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightOnSecondary,
      secondaryContainer: AppColors.lightSecondaryContainer,
      onSecondaryContainer: AppColors.lightOnSecondaryContainer,
      tertiary: AppColors.lightTertiary,
      onTertiary: AppColors.lightOnTertiary,
      tertiaryContainer: AppColors.lightTertiaryContainer,
      onTertiaryContainer: AppColors.lightOnTertiaryContainer,
      error: AppColors.lightError,
      onError: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      surfaceContainerHighest: AppColors.lightSurfaceContainerHighest,
      surfaceContainerHigh: AppColors.lightSurfaceContainerHigh,
      surfaceContainer: AppColors.lightSurfaceContainer,
      surfaceContainerLow: AppColors.lightSurfaceContainerLow,
      surfaceContainerLowest: Colors.white,
      surfaceDim: AppColors.lightSurfaceDim,
      surfaceBright: AppColors.lightSurface,
      onSurfaceVariant: AppColors.lightOnSurfaceVariant,
      outline: AppColors.lightOutline,
      outlineVariant: AppColors.lightOutlineVariant,
      inverseSurface: AppColors.darkSurface,
      onInverseSurface: AppColors.darkOnSurface,
      inversePrimary: AppColors.darkPrimary,
      scrim: Colors.black,
      shadow: Colors.black26,
    );

    return _buildTheme(cs);
  }

  static ThemeData get dark {
    const cs = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      primaryContainer: AppColors.darkPrimaryContainer,
      onPrimaryContainer: AppColors.darkOnPrimaryContainer,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      secondaryContainer: AppColors.darkSecondaryContainer,
      onSecondaryContainer: AppColors.darkOnSecondaryContainer,
      tertiary: AppColors.darkTertiary,
      onTertiary: AppColors.darkOnTertiary,
      tertiaryContainer: AppColors.darkTertiaryContainer,
      onTertiaryContainer: AppColors.darkOnTertiaryContainer,
      error: AppColors.darkError,
      onError: Colors.white,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      surfaceContainerHighest: AppColors.darkSurfaceContainerHighest,
      surfaceContainerHigh: AppColors.darkSurfaceContainerHigh,
      surfaceContainer: AppColors.darkSurfaceContainer,
      surfaceContainerLow: AppColors.darkSurfaceContainerLow,
      surfaceContainerLowest: AppColors.darkBackground,
      surfaceDim: AppColors.darkSurfaceDim,
      surfaceBright: AppColors.darkSurfaceBright,
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,
      outline: AppColors.darkOutline,
      outlineVariant: AppColors.darkOutlineVariant,
      inverseSurface: AppColors.lightSurface,
      onInverseSurface: AppColors.lightOnSurface,
      inversePrimary: AppColors.lightPrimary,
      scrim: Colors.black,
      shadow: Colors.black,
    );

    return _buildTheme(cs);
  }

  static ThemeData _buildTheme(ColorScheme cs) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      brightness: cs.brightness,
      scaffoldBackgroundColor: cs.surfaceContainerLowest,

      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: cs.shadow.withValues(alpha: 0.08),
      ),

      cardTheme: CardThemeData(
        color: cs.surfaceContainerHigh,
        elevation: 1,
        shadowColor: cs.shadow.withValues(alpha: 0.06),
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.outline),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surfaceContainerHighest,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: cs.error),
        ),
      ),

      listTileTheme: const ListTileThemeData(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: cs.secondaryContainer,
        labelStyle: TextStyle(
          color: cs.onSecondaryContainer,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: cs.outlineVariant,
        thickness: 0.5,
        space: 0,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: cs.primary,
        linearTrackColor: cs.surfaceContainerHighest,
        circularTrackColor: cs.surfaceContainerHighest,
      ),
    );
  }
}
