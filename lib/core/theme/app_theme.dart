import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central brand color — used in both themes.
const _kPrimary = Color(0xFF54408C); // original purple brand
const _kPrimaryDark = Color(0xFF9B8ED4); // lighter variant readable on dark bg

// ─── Light surface palette ──────────────────────────────────────────────────
const _kLightBg = Color(0xFFFFFFFF);
const _kLightSurface = Color(0xFFFAFAFA);
const _kLightInputFill = Color(0xFFFAFAFA);
const _kLightDivider = Color(0xFFE0E0E0);
const _kLightText = Color(0xFF212121);
const _kLightSubText = Color(0xFF616161);
const _kLightCard = Color(0xFFFFFFFF);

abstract class AppTheme {
  // ────────────────────────────── LIGHT ─────────────────────────────────────
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    useMaterial3: false,
    primaryColor: _kPrimary,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

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
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(splashFactory: NoSplash.splashFactory),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
        splashFactory: NoSplash.splashFactory,
        textStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _kPrimary,
        splashFactory: NoSplash.splashFactory,
      ),
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
        (s) =>
            s.contains(WidgetState.selected)
                ? _kPrimary.withOpacity(0.5)
                : Colors.grey.withOpacity(0.3),
      ),
    ),

    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      bodyLarge: GoogleFonts.roboto(color: _kLightText, fontSize: 16),
      bodyMedium: GoogleFonts.roboto(color: _kLightText, fontSize: 14),
      bodySmall: GoogleFonts.roboto(color: _kLightSubText, fontSize: 12),
      titleLarge: GoogleFonts.roboto(
        color: _kLightText,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.roboto(
        color: _kLightText,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
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
}
