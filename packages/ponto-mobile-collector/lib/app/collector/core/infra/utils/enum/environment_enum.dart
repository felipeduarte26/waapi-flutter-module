import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

enum EnvironmentEnum {
  dev(path: 'cloud-leaf.senior.com.br'),
  homolog(path: 'platform-homologx.senior.com.br'),
  prod(path: 'platform.senior.com.br'),
  test(path: 'cloud-leaf.senior.com.br');

  final String path;

  const EnvironmentEnum({required this.path});

  static EnvironmentEnum build(String value) {
    if (value == EnvironmentEnum.dev.name) {
      return EnvironmentEnum.dev;
    }

    if (value == EnvironmentEnum.homolog.name) {
      return EnvironmentEnum.homolog;
    }

    if (value == EnvironmentEnum.prod.name) {
      return EnvironmentEnum.prod;
    }

    if (value == EnvironmentEnum.test.name) {
      return EnvironmentEnum.test;
    }

    throw Exception('EnvironmentEnum not found.');
  }

  static auth.Environment mapToAuth(EnvironmentEnum environmentEnum) {
    switch (environmentEnum) {
      case EnvironmentEnum.test:
        return auth.Environment.dev;
      case EnvironmentEnum.dev:
        return auth.Environment.dev;
      case EnvironmentEnum.homolog:
        return auth.Environment.homolog;
      case EnvironmentEnum.prod:
        return auth.Environment.prod;
    }
  }

  static clock.ClockingEventEnvironmentEnum mapToClock(
    EnvironmentEnum environmentEnum,
  ) {
    switch (environmentEnum) {
      case EnvironmentEnum.test:
        return clock.ClockingEventEnvironmentEnum.dev;
      case EnvironmentEnum.dev:
        return clock.ClockingEventEnvironmentEnum.dev;
      case EnvironmentEnum.homolog:
        return clock.ClockingEventEnvironmentEnum.homolog;
      case EnvironmentEnum.prod:
        return clock.ClockingEventEnvironmentEnum.prod;
    }
  }
}
