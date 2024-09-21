
import 'package:flutter/material.dart';
import 'package:lingopanda/config/color_pallate.dart';
import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/core/constants/placeholder_descriptions.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
          PlaceholderDescriptions.appName,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorPalette.primary,
              fontSize: DisplayConstants.largeFontSize),
            );
  }
}
