import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingopanda/config/color_pallate.dart';
import 'package:lingopanda/core/constants/constants.dart';

ThemeData baseTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorPalette.primary,
    foregroundColor: ColorPalette.primary,
  ),
  primaryColor: ColorPalette.primary,
  scaffoldBackgroundColor: ColorPalette.appGrey,
  secondaryHeaderColor: ColorPalette.secondary,
  fontFamily: GoogleFonts.poppins().fontFamily,
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
        horizontal: DisplayConstants.largePadding,
        vertical: DisplayConstants.smallPadding),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(DisplayConstants.generalBorderRadius)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(DisplayConstants.generalBorderRadius)),
      borderSide: BorderSide.none,
    ),
    activeIndicatorBorder: BorderSide(color: ColorPalette.primary),
    // labelStyle: TextStyle(color: ColorPalette.appGrey),
    hintStyle:
        TextStyle(color: ColorPalette.secondary, fontWeight: FontWeight.normal),
    fillColor: Colors.white,
    filled: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
          horizontal: DisplayConstants.xxlargePadding,
          vertical: DisplayConstants.generalPadding),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(DisplayConstants.smallBorderRadius)),
      ),
      foregroundColor: Colors.white,
      backgroundColor: ColorPalette.primary,
    ),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      bodyLarge: TextStyle(
        fontSize: DisplayConstants.generalFontSize,
      ),
      bodyMedium: TextStyle(
        fontSize: DisplayConstants.smallFontSize,
      ),
      bodySmall: TextStyle(
        fontSize: DisplayConstants.smallFontSize,
      ),
    ),
  ),
);
