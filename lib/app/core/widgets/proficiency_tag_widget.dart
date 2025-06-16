import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class ProficiencyTagWidget extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final bool disabled;

  const ProficiencyTagWidget({
    Key? key,
    required this.label,
    required this.color,
    this.icon,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var proficiencyTagColor = disabled ? SeniorColors.secondaryColor600 : color;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.xxsmall,
        vertical: SeniorSpacing.xxxsmall,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(
                    right: SeniorRadius.xbig,
                  ),
                  child: SeniorIcon(
                    icon: icon!,
                    style: SeniorIconStyle(
                      color: proficiencyTagColor,
                    ),
                    size: SeniorIconSize.small,
                  ),
                ),
          Expanded(
            child: SeniorText.small(
              label,
              color: proficiencyTagColor,
              textProperties: const TextProperties(
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
