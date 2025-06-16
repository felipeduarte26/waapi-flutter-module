import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';

class MockInternalClockService extends Mock
    implements clock.IInternalClockService {}

void main() {
  late clock.IInternalClockService internalClockService;

  setUp(
    () {
      internalClockService = MockInternalClockService();
    },
  );

  group(
    'GetClockDateTimeUsecase',
    () {
      test(
        'call test.',
        () async {
          DateTime dateTime = DateTime.now();

          when(
            () => internalClockService.getClockDateTime(),
          ).thenReturn(dateTime);

          IGetClockDateTimeUsecase getClockDateTimeUsecase =
              GetClockDateTimeUsecase(
            internalClockService: internalClockService,
          );

          expect(dateTime, getClockDateTimeUsecase.call());

          verify(
            () => internalClockService.getClockDateTime(),
          ).called(1);

          verifyNoMoreInteractions(internalClockService);
        },
      );
    },
  );
}
