import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class SocialSearchBadge extends StatelessWidget {
  final String label;
  final Function(dynamic value) onSelect;
  final bool selected;
  const SocialSearchBadge({
    required this.label,
    required this.onSelect,
    required this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return Padding(
      padding: const EdgeInsets.only(right: SeniorSpacing.small),
      child: SeniorBadge(
        shape: SeniorBadgeShape.pill,
        backgroundColor: themeRepository.isDarkTheme() ? SeniorColors.grayscale100 : SeniorColors.pureWhite,
        textStyle: SeniorTypography.body(color: _getFontColor(themeRepository)),
        padding: const EdgeInsets.symmetric(
          horizontal: SeniorSpacing.normal,
          vertical: SeniorSpacing.xsmall,
        ),
        outlined: !selected,
        fontColor: themeRepository.isDarkTheme() ? SeniorColors.grayscale5 : SeniorColors.grayscale90,
        selected: selected,
        selectedBackgroundColor: themeRepository.isCustomTheme()
            ? themeRepository.theme.primaryColor!.withValues(alpha: 0.4)
            : SeniorColors.primaryColor100,
        label: label,
        onSelect: onSelect,
      ),
    );
  }

  Color _getFontColor(ThemeRepository themeRepository) {
    if (selected) {
      return themeRepository.isCustomTheme()
          ? SeniorServiceColor.getOptimalContrastColorTheme(
              color: themeRepository.theme.primaryColor!.withValues(alpha: 0.4),
            )
          : SeniorColors.primaryColor700;
    }
    return themeRepository.isDarkTheme() ? SeniorColors.grayscale5 : SeniorColors.grayscale90;
  }
}
