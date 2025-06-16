import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_radius.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../senior_design_system.dart';

class SeniorStrokeTop extends StatelessWidget {
  const SeniorStrokeTop({
    super.key,
    required this.seniorCalendarStyle,
  });

  final SeniorCalendarStyle? seniorCalendarStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Container(
      height: 4.0,
      width: 62.0,
      margin: const EdgeInsets.only(bottom: SeniorSpacing.normal),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SeniorRadius.xxbig),
        color: seniorCalendarStyle?.topLineColor ??
            theme.calendarTheme?.style?.topLineColor ??
            SeniorColors.grayscale30,
      ),
    );
  }
}
