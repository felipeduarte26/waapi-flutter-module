import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../ponto_mobile_collector.dart';

class JourneyButtonWidget extends StatelessWidget {
  final DriversWorkStatusEnum driversWorkStatus;
  final DriversJourneyEvent eventToAdd;
  final DriversWorkStatusButtonEnum driversWorkStatusButton;
  final void Function(DriversJourneyEvent driversJourneyEvent) onPressed;
  final bool disabled;

  JourneyButtonWidget({
    super.key,
    required this.driversWorkStatus,
    required this.eventToAdd,
    required this.onPressed,
    this.disabled = false,
  }) : driversWorkStatusButton =
            DriversWorkStatusButtonEnum.values.byName(driversWorkStatus.name);

  @override
  Widget build(BuildContext context) {
    final (
      isSecondaryButton,
      isOutlined,
      label,
    ) = (
      driversWorkStatusButton.isSecondaryButton,
      driversWorkStatusButton.isOutlined,
      driversWorkStatusButton.label(context),
    );

    if (isSecondaryButton) {
      return SeniorButton.secondary(
        fullWidth: true,
        label: label,
        onPressed: () => onPressed(eventToAdd),
        disabled: disabled,
      );
    }

    return SeniorButton(
      fullWidth: true,
      outlined: isOutlined,
      label: label,
      onPressed: () => onPressed(eventToAdd),
      disabled: disabled,
    );
  }
}
