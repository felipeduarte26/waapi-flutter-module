import 'package:flutter/material.dart';

import '../../../../../../ponto_mobile_collector.dart';

enum DriversWorkStatusIndicatorEnum {
  notStarted,

  working,

  driving,

  mandatoryBreak,

  foodTime,

  waiting;

  String Function(BuildContext) get status => _localizedStatus;

  String _localizedStatus(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);

    switch (this) {
      case DriversWorkStatusIndicatorEnum.notStarted:
        return collectorLocalizations.notStarted;

      case DriversWorkStatusIndicatorEnum.working:
        return collectorLocalizations.working;

      case DriversWorkStatusIndicatorEnum.driving:
        return collectorLocalizations.driving;

      case DriversWorkStatusIndicatorEnum.mandatoryBreak:
        return collectorLocalizations.mandatoryBreak;

      case DriversWorkStatusIndicatorEnum.foodTime:
        return collectorLocalizations.foodTime;

      case DriversWorkStatusIndicatorEnum.waiting:
        return collectorLocalizations.waiting;
    }
  }
}
