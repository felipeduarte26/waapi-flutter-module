import '../enums/clocking_event_use_type.dart';
import '../input_model/clocking_event_register_type.dart';

abstract class ICheckNeedFacialRecognitionByClockingEventTypeUsecase {
  bool call({
    required ClockingEventRegisterType clockingEventRegisterType,
  });
}

class CheckNeedFacialRecognitionByClockingEventTypeUsecase
    implements ICheckNeedFacialRecognitionByClockingEventTypeUsecase {
  @override
  bool call({
    required ClockingEventRegisterType clockingEventRegisterType,
  }) {
    var needFacialRecognition = true;

    if (clockingEventRegisterType is ClockingEventRegisterTypeDriver) {
      if (clockingEventRegisterType.clockingEventUse !=
          ClockingEventUseType.clockingEvent) {
        needFacialRecognition = false;
      }
    }

    return needFacialRecognition;
  }
}
