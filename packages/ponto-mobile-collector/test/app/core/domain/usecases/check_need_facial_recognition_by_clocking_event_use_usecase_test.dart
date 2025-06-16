import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_need_facial_recognition_by_clocking_event_use_usecase.dart';

class MockClockingEventRegisterType extends Mock
    implements ClockingEventRegisterType {}

void main() {
  late CheckNeedFacialRecognitionByClockingEventTypeUsecase
      checkNeedFacialRecognitionByClockingEventTypeUsecase;

  setUp(() {
    checkNeedFacialRecognitionByClockingEventTypeUsecase =
        CheckNeedFacialRecognitionByClockingEventTypeUsecase();
  });

  test(
    'Should return [true] when [clockingEventRegisterType] is not ClockingEventRegisterTypeDriver',
    () {
      final result = checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
        clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      );

      expect(
        result,
        true,
      );
    },
  );

  test(
    'should return [true] when [clockingEventRegisterType] is ClockingEventRegisterTypeDriver and [clockingEventUse] is clockingEvent',
    () {
      final result = checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
        clockingEventRegisterType: ClockingEventRegisterTypeDriver(
          journeyId: 'journeyId',
          clockingEventUse: ClockingEventUseType.clockingEvent,
          isMealBreak: false,
          journeyEventName: 'StartJourneyEvent',
        ),
      );

      expect(
        result,
        true,
      );
    },
  );

  test(
    'should return [false] when [clockingEventRegisterType] is ClockingEventRegisterTypeDriver and [clockingEventUse] is not clockingEvent',
    () {
      final result = checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
        clockingEventRegisterType: ClockingEventRegisterTypeDriver(
          journeyId: 'journeyId',
          clockingEventUse: ClockingEventUseType.driving,
          isMealBreak: false,
          journeyEventName: 'StartDrivingEvent',
        ),
      );

      expect(
        result,
        false,
      );
    },
  );
}
