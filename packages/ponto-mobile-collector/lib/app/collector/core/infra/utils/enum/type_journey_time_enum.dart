import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../domain/enums/clocking_event_use_enum.dart';

enum TypeJourneyTimeEnum {
  clockingEvent,
  paidBreak,
  mandatoryBreak,
  driving,
  waiting,
  working,
  mealBreak;

  static int toInt(TypeJourneyTimeEnum value) {
    switch (value) {
      case TypeJourneyTimeEnum.clockingEvent:
        return ClockingEventUseEnum.clockingEvent.codigo;
      case TypeJourneyTimeEnum.paidBreak:
        return ClockingEventUseEnum.paidBreak.codigo;
      case TypeJourneyTimeEnum.waiting:
        return ClockingEventUseEnum.waiting.codigo;
      case TypeJourneyTimeEnum.mandatoryBreak:
        return ClockingEventUseEnum.mandatoryBreak.codigo;
      case TypeJourneyTimeEnum.driving:
        return ClockingEventUseEnum.driving.codigo;
      case TypeJourneyTimeEnum.working:
        return 98;
      case TypeJourneyTimeEnum.mealBreak:
        return 99;
    }
  }

  static TypeJourneyTimeEnum? fromInt(int value) {
    if (value == ClockingEventUseEnum.clockingEvent.codigo) {
      return TypeJourneyTimeEnum.clockingEvent;
    }
    if (value == ClockingEventUseEnum.paidBreak.codigo) {
      return TypeJourneyTimeEnum.paidBreak;
    }
    if (value == ClockingEventUseEnum.mandatoryBreak.codigo) {
      return TypeJourneyTimeEnum.mandatoryBreak;
    }
    if (value == ClockingEventUseEnum.driving.codigo) {
      return TypeJourneyTimeEnum.driving;
    }

    if (value == ClockingEventUseEnum.waiting.codigo) {
      return TypeJourneyTimeEnum.waiting;
    }

    throw Exception('Invalid value for TypeJourneyTimeEnum.');
  }

  String Function(BuildContext) get status => _localizedStatus;
  IconData Function(BuildContext) get icon => _iconData;

  String _localizedStatus(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);

    switch (this) {
      case TypeJourneyTimeEnum.clockingEvent:
        return collectorLocalizations.work;

      case TypeJourneyTimeEnum.driving:
        return collectorLocalizations.drive;

      case TypeJourneyTimeEnum.mandatoryBreak:
        return collectorLocalizations.mandatoryBreak;

      case TypeJourneyTimeEnum.mealBreak:
        return collectorLocalizations.foodTimeOrBreaks;

      case TypeJourneyTimeEnum.waiting:
        return collectorLocalizations.timeInWaiting;

      case TypeJourneyTimeEnum.paidBreak:
        return collectorLocalizations.paidBreak;

      case TypeJourneyTimeEnum.working:
        return collectorLocalizations.work;
    }
  }

  IconData _iconData(BuildContext context) {
    switch (this) {
      case TypeJourneyTimeEnum.clockingEvent:
        return FontAwesomeIcons.businessTime;

      case TypeJourneyTimeEnum.driving:
        return FontAwesomeIcons.truck;

      case TypeJourneyTimeEnum.mandatoryBreak:
        return FontAwesomeIcons.solidCirclePause;

      case TypeJourneyTimeEnum.mealBreak:
        return FontAwesomeIcons.utensils;

      case TypeJourneyTimeEnum.waiting:
        return FontAwesomeIcons.solidHand;

      case TypeJourneyTimeEnum.paidBreak:
        return FontAwesomeIcons.solidCirclePause;

      case TypeJourneyTimeEnum.working:
        return FontAwesomeIcons.businessTime;
    }
  }

  static TypeJourneyTimeEnum build(String name) {
    if (name == TypeJourneyTimeEnum.clockingEvent.name) {
      return TypeJourneyTimeEnum.clockingEvent;
    }
    if (name == TypeJourneyTimeEnum.paidBreak.name) {
      return TypeJourneyTimeEnum.paidBreak;
    }
    if (name == TypeJourneyTimeEnum.mandatoryBreak.name) {
      return TypeJourneyTimeEnum.mandatoryBreak;
    }
    if (name == TypeJourneyTimeEnum.driving.name) {
      return TypeJourneyTimeEnum.driving;
    }
    if (name == TypeJourneyTimeEnum.waiting.name) {
      return TypeJourneyTimeEnum.waiting;
    }
    if (name == TypeJourneyTimeEnum.mealBreak.name) {
      return TypeJourneyTimeEnum.mealBreak;
    }
    if (name == TypeJourneyTimeEnum.working.name) {
      return TypeJourneyTimeEnum.working;
    }
    throw Exception('TypeJourneyTimeEnum not found.');
  }
}
