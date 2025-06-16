import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/get_environment_repository_impl.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockEnvironmentService extends Mock implements IEnvironmentService {}

void main() {
  late IEnvironmentService environmentService;
  late GetEnvironmentRepositoryImpl getEnvironmentRepositoryImpl;

  setUp(() {
    environmentService = MockEnvironmentService();
    getEnvironmentRepositoryImpl = GetEnvironmentRepositoryImpl(
      environmentService: environmentService,
    );

    when(
      () => environmentService.environment(),
    ).thenAnswer(
      (invocation) => EnvironmentEnum.dev,
    );
  });

  group('GetEnvironmentRepositoryImpl', () {
    test('call test', () async {
      EnvironmentEnum environmentEnum =
          await getEnvironmentRepositoryImpl.call();

      expect(environmentEnum, EnvironmentEnum.dev);
    });
  });
}
