import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/color_extension.dart';
import '../../domain/entities/proficiency_feedback_entity.dart';
import 'icon_proficiency_widget.dart';

class ProficiencyItemWidget extends StatelessWidget {
  final ProficiencyFeedbackEntity proficiency;
  final Function(ProficiencyFeedbackEntity) onTap;
  final bool selected;
  final bool disabled;

  const ProficiencyItemWidget({
    super.key,
    required this.proficiency,
    required this.onTap,
    required this.selected,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final selectedBackgroundColor = ColorExtension.fromHex(
      hexString: proficiency.color,
      defaultColor: themeRepository.isCustomTheme() ? themeRepository.theme.primaryColor! : SeniorColors.primaryColor,
    );
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(SeniorSpacing.xxbig)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(SeniorSpacing.xxbig)),
        onTap: disabled ? null : () => onTap(proficiency),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected
                ? Provider.of<ThemeRepository>(context).isDarkTheme()
                    ? SeniorColors.primaryColor100
                    : ColorExtension.fromHex(
                        hexString: proficiency.color,
                        defaultColor: SeniorColors.primaryColor,
                      )
                : Provider.of<ThemeRepository>(context).isDarkTheme()
                    ? Provider.of<ThemeRepository>(context).theme.cardTheme!.style!.backgroundColor
                    : SeniorColors.secondaryColor300,
            borderRadius: const BorderRadius.all(Radius.circular(SeniorSpacing.xxbig)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.xsmall),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconProficiencyWidget(
                  proficiencyFeedbackEntity: proficiency,
                ),
                Center(
                  child: SeniorText.small(
                    proficiency.name,
                    color: themeRepository.isCustomTheme()
                        ? SeniorServiceColor.getOptimalContrastColorTheme(color: selectedBackgroundColor)
                        : SeniorColors.pureWhite,
                    darkColor: selected ? SeniorColors.primaryColor700 : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
