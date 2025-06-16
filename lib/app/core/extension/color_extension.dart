import 'package:flutter/material.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';

extension ColorExtension on Color {
  static Color fromHex({
    required String hexString,
    Color defaultColor = SeniorColors.pureWhite,
  }) {
    var placeholderColor = defaultColor;

    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) {
        buffer.write('ff');
      }
      buffer.write(
        hexString.replaceFirst('#', ''),
      );
      return Color(
        int.parse(
          buffer.toString(),
          radix: 16,
        ),
      );
    } on FormatException {
      return placeholderColor;
    }
  }
}
