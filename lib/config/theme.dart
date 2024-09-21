import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lingopanda/config/color_pallate.dart';

ThemeData baseTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorPalette.primary,
    foregroundColor: ColorPalette.primary,
  ),
  primaryColor: ColorPalette.primary,
  scaffoldBackgroundColor: ColorPalette.appGrey,
  secondaryHeaderColor: ColorPalette.secondary,
  fontFamily: 'poppins',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'poppins',
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      foregroundColor: Colors.white,
      backgroundColor: ColorPalette.primary,
    ),
  ),
);
