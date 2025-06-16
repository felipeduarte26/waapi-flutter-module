import '../enums/clocking_event_use_type.dart';

abstract class ClockingEventRegisterType {}

class ClockingEventRegisterTypeSession extends ClockingEventRegisterType {}

class ClockingEventRegisterTypeDriver extends ClockingEventRegisterType {
  final String journeyId;
  final ClockingEventUseType clockingEventUse;
  final bool isMealBreak;
  final String journeyEventName;

  ClockingEventRegisterTypeDriver({
    required this.journeyId,
    required this.clockingEventUse,
    required this.isMealBreak,
    required this.journeyEventName,
  });
}

class ClockingEventRegisterTypeNFC extends ClockingEventRegisterType {
  final String employeeId;
  ClockingEventRegisterTypeNFC({required this.employeeId});
}

class ClockingEventRegisterTypeQRCode extends ClockingEventRegisterType {
  final String employeeId;
  ClockingEventRegisterTypeQRCode({required this.employeeId});
}

class ClockingEventRegisterTypeFacialRecognition
    extends ClockingEventRegisterType {
  final String employeeId;
  ClockingEventRegisterTypeFacialRecognition({required this.employeeId});
}

class ClockingEventRegisterTypeEmailPassword extends ClockingEventRegisterType {
  final String employeeId;
  ClockingEventRegisterTypeEmailPassword({required this.employeeId});
}
