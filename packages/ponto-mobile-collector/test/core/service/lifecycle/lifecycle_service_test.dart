import 'package:datetime_setting/datetime_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/lifecycle/ilifecycle_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/lifecycle/lifecycle_service.dart';

class MockDatetimeSetting extends Mock implements DatetimeSetting {
  Future<bool> timeIsAuto() {
    return Future(() => true);
  }
}

void main() {
  late LifecycleService lifecycleServiceImpl;

  setUp(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      LifecycleService.addObserver = true;
      lifecycleServiceImpl = LifecycleService();
    },
  );

  tearDown(
    () {
      lifecycleServiceImpl.dispose();
    },
  );

  group(
    'LifecycleService',
    () {
      test(
        'didChangeAppLifecycleState test',
        () async {
          ILifecycleService service = lifecycleServiceImpl;
          lifecycleServiceImpl
              .didChangeAppLifecycleState(AppLifecycleState.paused);
          expect(service.getState(), AppLifecycleState.paused);
        },
      );

      test(
        'getState test',
        () async {
          ILifecycleService service = lifecycleServiceImpl;
          expect(service.getState(), AppLifecycleState.resumed);
          expect(LifecycleService.addObserver, false);
        },
      );

      test(
        'getStream test',
        () async {
          ILifecycleService service = lifecycleServiceImpl;
          expect(service.getStream(), isA<Stream<AppLifecycleState>>());
        },
      );
    },
  );
}
