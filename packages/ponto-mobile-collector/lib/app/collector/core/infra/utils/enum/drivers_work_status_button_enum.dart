import 'package:flutter/material.dart';

import '../../../../../../ponto_mobile_collector.dart';

enum DriversWorkStatusButtonEnum {
  notStarted(),

  working(
    isSecondaryButton: true,
  ),

  driving(
    isOutlined: true,
  ),

  mandatoryBreak(
    isOutlined: true,
  ),

  foodTime(
    isOutlined: true,
  ),

  waiting(
    isOutlined: true,
  );

  final bool isSecondaryButton;
  final bool isOutlined;

  const DriversWorkStatusButtonEnum({
    this.isSecondaryButton = false,
    this.isOutlined = false,
  });

  String Function(BuildContext) get label => _localizedLabel;

  String _localizedLabel(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);

    switch (this) {
      case DriversWorkStatusButtonEnum.notStarted:
        return collectorLocalizations.startJourney;

      case DriversWorkStatusButtonEnum.working:
        return collectorLocalizations.newJourney;

      case DriversWorkStatusButtonEnum.driving:
        return collectorLocalizations.stopDriving;

      case DriversWorkStatusButtonEnum.mandatoryBreak:
        return collectorLocalizations.stopMandatoryBreak;

      case DriversWorkStatusButtonEnum.foodTime:
        return collectorLocalizations.stopFoodTime;

      case DriversWorkStatusButtonEnum.waiting:
        return collectorLocalizations.stopWaiting;
    }
  }
}
