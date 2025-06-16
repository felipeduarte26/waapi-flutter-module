import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/configuration_entity_mock.dart';
import '../../../../../mocks/platform_user_entity_mock.dart';

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

void main() {
  late GetAllowGpoOnAppUsecase getAllowGpoOnAppUsecase;
  late IConfigurationRepository configurationRepository;

  setUp(() {
    configurationRepository = MockConfigurationRepository();

    when(
      () => configurationRepository.findByUsername(
          username: platformUserMock.platformUserName!,),
    ).thenAnswer(
      (_) async => configurationEntityMock,
    );

    getAllowGpoOnAppUsecase = GetAllowGpoOnAppUsecaseimpl(
      configurationRepository: configurationRepository,
    );
  });

  group('GetAllowGpoOnAppUsecase', () {
    test('get true allow gpo on app test', () async {
      when(
        () => configurationRepository.findByUsername(
            username: platformUserMock.platformUserName!,),
      ).thenAnswer(
        (_) async => configurationEntityMock,
      );
      var result = await getAllowGpoOnAppUsecase.call(
          username: platformUserMock.platformUserName!,);
      expect(result, true);
      verify(
        () => configurationRepository.findByUsername(
            username: platformUserMock.platformUserName!,),
      );
      verifyNoMoreInteractions(configurationRepository);
    });
  });
}
