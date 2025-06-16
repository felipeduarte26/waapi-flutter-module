import 'package:flutter/material.dart';

import '../../../../../../ponto_mobile_collector.dart';

enum DriversWorkStatusTimerIndicatorEnum {
  working,

  driving,

  mandatoryBreak,

  foodTime,

  waiting;


  String Function(BuildContext) get label => _localizedLabel;

  String _localizedLabel(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);

    switch (this) {
      case DriversWorkStatusTimerIndicatorEnum.working:
        return collectorLocalizations.timeInWorking;

      case DriversWorkStatusTimerIndicatorEnum.driving:
        return collectorLocalizations.timeInDriving;

      case DriversWorkStatusTimerIndicatorEnum.mandatoryBreak:
        return collectorLocalizations.timeInMandatoryBreak;

      case DriversWorkStatusTimerIndicatorEnum.foodTime:
        return collectorLocalizations.timeInFoodTime;

      case DriversWorkStatusTimerIndicatorEnum.waiting:
        return collectorLocalizations.timeInWaiting;
    }
  }
}
