import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockPlatformService extends Mock implements IPlatformService {}

void main() {
  late IHasConnectivityUsecase hasConnectivityUsecase;
  late IPlatformService platformService;

  setUp(() {
    platformService = MockPlatformService();
    hasConnectivityUsecase =
        HasConnectivityUsecase(platformService: platformService);
  });

  group('HasConnectivityUsecase', () {
    test('successful call test', () async {
      when(() => platformService.hasConnectivity())
          .thenAnswer((_) async => true);

      expect(await hasConnectivityUsecase.call(), true);
      verify(() => platformService.hasConnectivity()).called(1);
      verifyNoMoreInteractions(platformService);
    });
  });
}
