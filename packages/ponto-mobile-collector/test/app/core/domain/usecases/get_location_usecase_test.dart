import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/platform/iplatform_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_location_usecase.dart';

import '../../../../mocks/state_location_entity_mock.dart';

class MockPlatformService extends Mock implements IPlatformService {}

void main() {
  late GetLocationUsecase getLocationUsecase;
  late IPlatformService platformService;

  setUp(() {
    platformService = MockPlatformService();

    when(
      () => platformService.getLocation(),
    ).thenAnswer((_) async => stateLocationEntityMock);

    getLocationUsecase =
        GetLocationUsecaseImpl(platformService: platformService);
  });

  group('GetLocationUsecase', () {
    test('return location success test', () async {
      expect(await getLocationUsecase.call(), stateLocationEntityMock);
    });
  });
}
