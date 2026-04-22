import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central brand color — used in both themes.
const _kPrimary     = Color(0xFF54408C); // original purple brand
const _kPrimaryDark = Color(0xFF9B8ED4); // lighter variant readable on dark bg

// ─── Light surface palette ──────────────────────────────────────────────────
const _kLightBg        = Color(0xFFFFFFFF);
const _kLightSurface   = Color(0xFFFAFAFA);
const _kLightInputFill = Color(0xFFFAFAFA);
const _kLightDivider   = Color(0xFFE0E0E0);
const _kLightText      = Color(0xFF212121);
const _kLightSubText   = Color(0xFF616161);
const _kLightCard      = Color(0xFFFFFFFF);

// ─── Dark surface palette ────────────────────────────────────────────────────
const _kDarkBg        = Color(0xFF121212);
const _kDarkSurface   = Color(0xFF1E1E2C);
const _kDarkCard      = Color(0xFF252535);
const _kDarkInputFill = Color(0xFF252535);
const _kDarkDivider   = Color(0xFF2A2A3D);
const _kDarkText      = Color(0xFFF0F0F5);
const _kDarkSubText   = Color(0xFFA0A0B8);
const _kDarkAppBar    = Color(0xFF1A1A2E);

abstract class AppTheme {
  // ────────────────────────────── LIGHT ─────────────────────────────────────
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    useMaterial3: false,
    primaryColor: _kPrimary,

    colorScheme: const ColorScheme.light(
      primary: _kPrimary,
      secondary: _kPrimary,
      surface: _kLightSurface,
      onPrimary: Colors.white,
      onSurface: _kLightText,
      error: Color(0xFFF44336),
    ),

    scaffoldBackgroundColor: _kLightBg,

    appBarTheme: AppBarTheme(
      backgroundColor: _kLightBg,
      foregroundColor: _kLightText,
      elevation: 0,
      iconTheme: const IconThemeData(color: _kLightText),
      titleTextStyle: GoogleFonts.roboto(
        color: _kLightText,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),

    cardTheme: CardThemeData(
      color: _kLightCard,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
        textStyle: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: _kPrimary),
    ),

    iconTheme: const IconThemeData(color: _kLightText),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _kLightInputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: _kLightDivider, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: _kLightDivider, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: _kPrimary, width: 1.5),
      ),
      hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    ),

    dividerTheme: const DividerThemeData(
      color: _kLightDivider,
      thickness: 1,
      space: 1,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _kLightBg,
      selectedItemColor: _kPrimary,
      unselectedItemColor: _kLightSubText,
      elevation: 8,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: _kLightBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: GoogleFonts.roboto(
        color: _kLightText,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? _kPrimary : Colors.grey,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? _kPrimary.withValues(alpha: 0.5)
            : Colors.grey.withValues(alpha: 0.3),
      ),
    ),

    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      bodyLarge:   GoogleFonts.roboto(color: _kLightText, fontSize: 16),
      bodyMedium:  GoogleFonts.roboto(color: _kLightText, fontSize: 14),
      bodySmall:   GoogleFonts.roboto(color: _kLightSubText, fontSize: 12),
      titleLarge:  GoogleFonts.roboto(color: _kLightText, fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.roboto(color: _kLightText, fontSize: 18, fontWeight: FontWeight.w600),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: _kLightSurface,
      labelStyle: const TextStyle(color: _kLightText),
      side: const BorderSide(color: _kLightDivider),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _kLightBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
    ),
  );

  // ────────────────────────────── DARK ──────────────────────────────────────
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: false,
    primaryColor: _kPrimaryDark,

    colorScheme: const ColorScheme.dark(
      primary: _kPrimaryDark,
      secondary: _kPrimaryDark,
      surface: _kDarkSurface,
      onPrimary: Colors.white,
      onSurface: _kDarkText,
      error: Color(0xFFEF5350),
    ),

    scaffoldBackgroundColor: _kDarkBg,

    appBarTheme: AppBarTheme(
      backgroundColor: _kDarkAppBar,
      foregroundColor: _kDarkText,
      elevation: 0,
      iconTheme: const IconThemeData(color: _kDarkText),
      titleTextStyle: GoogleFonts.roboto(
        color: _kDarkText,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),

    cardTheme: CardThemeData(
      color: _kDarkCard,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _kPrimaryDark,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
        textStyle: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: _kPrimaryDark),
    ),

    iconTheme: const IconThemeData(color: _kDarkText),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _kDarkInputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: _kDarkDivider, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: _kDarkDivider, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: _kPrimaryDark, width: 1.5),
      ),
      hintStyle: const TextStyle(color: Color(0xFF6B6B8A)),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    ),

    dividerTheme: const DividerThemeData(
      color: _kDarkDivider,
      thickness: 1,
      space: 1,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _kDarkAppBar,
      selectedItemColor: _kPrimaryDark,
      unselectedItemColor: _kDarkSubText,
      elevation: 8,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: _kDarkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: GoogleFonts.roboto(
        color: _kDarkText,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? _kPrimaryDark : const Color(0xFF5A5A6A),
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? _kPrimaryDark.withValues(alpha: 0.5)
            : Colors.white.withValues(alpha: 0.1),
      ),
    ),

    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      bodyLarge:   GoogleFonts.roboto(color: _kDarkText, fontSize: 16),
      bodyMedium:  GoogleFonts.roboto(color: _kDarkText, fontSize: 14),
      bodySmall:   GoogleFonts.roboto(color: _kDarkSubText, fontSize: 12),
      titleLarge:  GoogleFonts.roboto(color: _kDarkText, fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.roboto(color: _kDarkText, fontSize: 18, fontWeight: FontWeight.w600),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: _kDarkCard,
      labelStyle: const TextStyle(color: _kDarkText),
      side: const BorderSide(color: _kDarkDivider),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _kDarkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
    ),
  );
}
