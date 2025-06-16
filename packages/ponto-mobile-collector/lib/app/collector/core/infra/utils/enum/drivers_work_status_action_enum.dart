import 'package:flutter/material.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';

enum DriversWorkStatusActionEnum {
  working(
    SeniorColors.primaryColor500,
    ClockingEventUseType.clockingEvent,
  ),

  driving(
    SeniorColors.manchesterColorBlue,
    ClockingEventUseType.driving,
  ),
  mandatoryBreak(
    SeniorColors.manchesterColorOrange,
    ClockingEventUseType.mandatoryBreak,
  ),
  waiting(
    SeniorColors.manchesterColorRed,
    ClockingEventUseType.waiting,
  ),
  foodTime(
    SeniorColors.manchesterColorYellow,
    ClockingEventUseType.clockingEvent,
    food: true,
  );

  final Color iconColor;
  final ClockingEventUseType clockingEventUseType;
  final bool food;

  const DriversWorkStatusActionEnum(
    this.iconColor,
    this.clockingEventUseType, {
    this.food = false,
  });

  String Function(BuildContext) get label => _localizedLabel;

  String _localizedLabel(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);

    switch (this) {
      case DriversWorkStatusActionEnum.working:
        return collectorLocalizations.working;

      case DriversWorkStatusActionEnum.driving:
        return collectorLocalizations.startDrivingWithLineBreak;

      case DriversWorkStatusActionEnum.mandatoryBreak:
        return collectorLocalizations.startMandatoryBreakWithLineBreak;

      case DriversWorkStatusActionEnum.waiting:
        return collectorLocalizations.startWaitingWithLineBreak;

      case DriversWorkStatusActionEnum.foodTime:
        return collectorLocalizations.startFoodTimeWithLineBreak;
    }
  }
}
