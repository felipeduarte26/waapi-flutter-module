import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class FeedbackCompetencyTagWidget extends StatelessWidget {
  final String displayLabel;

  const FeedbackCompetencyTagWidget({
    Key? key,
    required this.displayLabel,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      decoration: BoxDecoration(
        color: themeRepository.isCustomTheme()
            ? themeRepository.theme.primaryColor!.withOpacity(0.4)
            : SeniorColors.primaryColor200,
        borderRadius: const BorderRadius.all(Radius.circular(SeniorSpacing.xxbig)),
      ),
      child: Center(
        child: SeniorText.small(
          displayLabel,
          style: SeniorTypography.small(
            color: themeRepository.isCustomTheme()
                ? SeniorServiceColor.getOptimalContrastColorTheme(
                    color: themeRepository.theme.primaryColor!.withOpacity(0.4),
                  )
                : SeniorColors.grayscale80,
          ).copyWith(
            height: 1.0,
          ),
          textProperties: const TextProperties(
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
