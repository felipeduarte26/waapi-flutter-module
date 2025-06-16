import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'EnvironmentEnum test.',
    () {
      expect(
        EnvironmentEnum.build(EnvironmentEnum.dev.name),
        EnvironmentEnum.dev,
      );

      expect(
        EnvironmentEnum.build(EnvironmentEnum.homolog.name),
        EnvironmentEnum.homolog,
      );

      expect(
        EnvironmentEnum.build(EnvironmentEnum.prod.name),
        EnvironmentEnum.prod,
      );

      expect(
        () => EnvironmentEnum.build('error'),
        throwsA(
          isA<Exception>(),
        ),
      );

      expect(
        EnvironmentEnum.mapToAuth(EnvironmentEnum.test),
        auth.Environment.dev,
      );

      expect(
        EnvironmentEnum.mapToAuth(EnvironmentEnum.dev),
        auth.Environment.dev,
      );

      expect(
        EnvironmentEnum.mapToAuth(EnvironmentEnum.homolog),
        auth.Environment.homolog,
      );

      expect(
        EnvironmentEnum.mapToAuth(EnvironmentEnum.prod),
        auth.Environment.prod,
      );

      expect(
        EnvironmentEnum.mapToClock(EnvironmentEnum.test),
        clock.ClockingEventEnvironmentEnum.dev,
      );

      expect(
        EnvironmentEnum.mapToClock(EnvironmentEnum.dev),
        clock.ClockingEventEnvironmentEnum.dev,
      );

      expect(
        EnvironmentEnum.mapToClock(EnvironmentEnum.homolog),
        clock.ClockingEventEnvironmentEnum.homolog,
      );

      expect(
        EnvironmentEnum.mapToClock(EnvironmentEnum.prod),
        clock.ClockingEventEnvironmentEnum.prod,
      );
    },
  );
}
