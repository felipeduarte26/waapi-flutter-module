import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_observable_usecase.dart';

class MockInternalClockService extends Mock
    implements clock.IInternalClockService {}

void main() {
  late clock.Observable observable;
  late clock.IInternalClockService internalClockService;

  setUp(
    () {
      internalClockService = MockInternalClockService();
      observable = clock.Observable();
    },
  );

  group(
    'GetClockObservableUsecase',
    () {
      test(
        'call test.',
        () {
          IGetClockObservableUsecase getClockObservableUsecase =
              GetClockObservableUsecase(
            internalClockService: internalClockService,
          );

          when(
            () => internalClockService.getObservable(),
          ).thenReturn(observable);

          getClockObservableUsecase.call();

          verify(
            () => internalClockService.getObservable(),
          ).called(1);

          verifyNoMoreInteractions(internalClockService);
        },
      );
    },
  );
}
