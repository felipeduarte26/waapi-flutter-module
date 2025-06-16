import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/lifecycle/ilifecycle_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_lifecycle_stream_usecase.dart';

class MockLifecycleService extends Mock implements ILifecycleService {}

void main() {
  late ILifecycleService lifecycleService;
  late StreamController<AppLifecycleState> stateStreamController;

  setUp(
    () {
      stateStreamController = StreamController<AppLifecycleState>();
      lifecycleService = MockLifecycleService();
    },
  );

  tearDown(
    () {
      stateStreamController.close();
    },
  );

  group(
    'GetLifecycleStreamUsecase',
    () {
      test(
        'call test.',
        () {
          IGetLifecycleStreamUsecase initClockUsecase =
              GetLifecycleStreamUsecase(
            lifecycleService: lifecycleService,
          );

          when(
            () => lifecycleService.getStream(),
          ).thenAnswer((invocation) => stateStreamController.stream);

          initClockUsecase.call();

          verify(
            () => lifecycleService.getStream(),
          ).called(1);

          verifyNoMoreInteractions(lifecycleService);
        },
      );
    },
  );
}
