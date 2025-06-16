import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../repositories/repositories.dart';
import '../senior_calendar_style.dart';

class SeniorCalendarFooter extends StatelessWidget {
  const SeniorCalendarFooter({
    Key? key,
    this.text,
    this.style,
  }) : super(key: key);

  final String? text;
  final SeniorCalendarStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context, listen: false).theme;

    return text != null
        ? Padding(
            padding: const EdgeInsets.only(
              left: SeniorSpacing.normal,
              right: SeniorSpacing.normal,
              top: SeniorSpacing.small,
            ),
            child: Container(
              width: double.infinity,
              child: Text(
                text!,
                style: SeniorTypography.small(
                  color: style?.bottomTextColor ??
                      theme.calendarTheme?.style?.bottomTextColor ??
                      SeniorColors.grayscale70,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
