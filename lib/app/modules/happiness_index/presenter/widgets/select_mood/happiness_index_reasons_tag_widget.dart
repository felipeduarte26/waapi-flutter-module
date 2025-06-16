import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class HappinessIndexReasonsTagWidget extends StatelessWidget {
  final String displayLabel;
  final bool selected;
  final VoidCallback select;

  const HappinessIndexReasonsTagWidget({
    Key? key,
    required this.displayLabel,
    required this.selected,
    required this.select,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDark = themeRepository.isDarkTheme();
    return GestureDetector(
      onTap: select,
      child: Padding(
        padding: const EdgeInsets.only(
          right: SeniorSpacing.xsmall,
          bottom: SeniorSpacing.xsmall,
        ),
        child: Container(
          height: SeniorSpacing.medium,
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.xsmall,
          ),
          decoration: BoxDecoration(
            color: selected
                ? themeRepository.isCustomTheme()
                    ? themeRepository.theme.primaryColor!.withOpacity(0.4)
                    : SeniorColors.primaryColor200
                : isDark
                    ? themeRepository.theme.cardTheme!.style!.backgroundColor
                    : SeniorColors.pureWhite,
            borderRadius: const BorderRadius.all(Radius.circular(SeniorSpacing.xxbig)),
            border: selected
                ? Border.all(
                    color: SeniorColors.primaryColor200,
                    width: 1,
                  )
                : Border.all(
                    color: SeniorColors.secondaryColor200,
                    width: 1,
                  ),
          ),
          child: SeniorText.small(
            displayLabel,
            style: selected
                ? SeniorTypography.small(
                    color: themeRepository.isCustomTheme()
                        ? SeniorServiceColor.getOptimalContrastColorTheme(color: themeRepository.theme.primaryColor!)
                        : SeniorColors.primaryColor700,
                  )
                : null,
            textProperties: const TextProperties(
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
