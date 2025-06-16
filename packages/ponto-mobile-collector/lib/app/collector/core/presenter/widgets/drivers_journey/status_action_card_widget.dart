import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';

class StatusActionCardWidget extends StatelessWidget {
  final DriversJourneyEvent driversJourneyEvent;
  final DriversWorkStatusActionEnum actionType;
  final void Function(
    DriversJourneyEvent driversJourneyEvent,
  )? onPressed;
  final bool disabled;

  const StatusActionCardWidget({
    super.key,
    required this.driversJourneyEvent,
    required this.actionType,
    this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    final driversWorkStatusByActionType = DriversWorkStatusEnum.values.byName(
      actionType.name,
    );
    final (
      icon,
      iconColor,
      label,
      isSelected,
    ) = (
      driversWorkStatusByActionType.icon,
      actionType.iconColor,
      actionType.label(context),
      disabled,
    );

    return SeniorElevatedElement(
      elevation: SeniorElevations.dp01,
      borderRadius: 6,
      child: GestureDetector(
        onTap: !isSelected && onPressed != null
            ? () => onPressed!(driversJourneyEvent)
            : null,
        child: Container(
          height: 110,
          alignment: Alignment.topLeft,
          color: isSelected
              ? isDark
                  ? SeniorColors.grayscale70
                  : SeniorColors.grayscale5
              : isDark
                  ? SeniorColors.pureBlack
                  : SeniorColors.pureWhite,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: SeniorIconSize.medium,
                  color: isSelected
                      ? SeniorColors.primaryColor400.withOpacity(0.5)
                      : iconColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                SeniorText.labelBold(
                  label,
                  color: SeniorColors.grayscale90.withOpacity(
                    isSelected ? 0.5 : 1,
                  ),
                  darkColor: SeniorColors.pureWhite.withOpacity(
                    isSelected ? 0.5 : 1,
                  ),
                  textProperties: const TextProperties(
                    textAlign: TextAlign.left,
                    maxLines: 2,
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
