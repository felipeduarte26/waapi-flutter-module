import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_environment_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockEnvironmentService extends Mock implements IEnvironmentService {}

void main() {
  late IEnvironmentService environmentService;
  late GetEnvironmentUsecase getEnvironmentUsecase;

  setUp(() {
    environmentService = MockEnvironmentService();
    getEnvironmentUsecase = GetEnvironmentUsecaseImpl(
      environmentService: environmentService,
    );

    when(
      () => environmentService.environment(),
    ).thenAnswer(
      (invocation) => EnvironmentEnum.dev,
    );
  });

  group('GetEnvironmentUsecase', () {
    test('call test', () async {
      EnvironmentEnum environemnt = await getEnvironmentUsecase.call();
      expect(environemnt, EnvironmentEnum.dev);
    });
  });
}
