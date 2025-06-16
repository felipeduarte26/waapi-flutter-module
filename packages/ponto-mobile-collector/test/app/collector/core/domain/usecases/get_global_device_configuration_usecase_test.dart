import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_device_configuration_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/get_global_device_configuration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_global_device_configuration_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/global_configuration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/init_clock_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/device_configuration_mock.dart';
import '../../../../../mocks/device_entity_mock.dart';
import '../../../../../mocks/device_info_mock.dart';
import '../../../../../mocks/global_configuration_entity_mock.dart';
import '../../../../../mocks/global_device_configuration_entity_mock.dart';

class MockGetGlobalDeviceConfigurationRepository extends Mock
    implements GetGlobalDeviceConfigurationRepository {}

class MockDeviceConfigurationRepository extends Mock
    implements DeviceConfigurationRepository {}

class MockGlobalConfigurationRepository extends Mock
    implements GlobalConfigurationRepository {}

class MockIPlatformService extends Mock implements IPlatformService {}

class MockDeviceRepository extends Mock implements IDeviceRepository {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

class MockInitClockUsecase extends Mock implements InitClockUsecase {}

class MockLogService extends Mock implements LogService {}

void main() {
  late GetGlobalDeviceConfigurationUsecase getGlobalDeviceConfigurationUsecase;
  late GetGlobalDeviceConfigurationRepository
      getGlobalDeviceConfigurationRepository;
  late DeviceConfigurationRepository deviceConfigurationRepository;
  late GlobalConfigurationRepository globalConfigurationRepository;
  late IPlatformService platformService;
  late IDeviceRepository deviceRepository;
  late GetAccessTokenUsecase getAccessTokenUsecase;
  late InitClockUsecase initClockUsecase;
  late LogService logService;

  setUp(() {
    getGlobalDeviceConfigurationRepository =
        MockGetGlobalDeviceConfigurationRepository();
    deviceConfigurationRepository = MockDeviceConfigurationRepository();
    globalConfigurationRepository = MockGlobalConfigurationRepository();
    platformService = MockIPlatformService();
    deviceRepository = MockDeviceRepository();
    getAccessTokenUsecase = MockGetAccessTokenUsecase();
    initClockUsecase = MockInitClockUsecase();
    logService = MockLogService();

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    when(
      () => platformService.getDeviceInfoDto(),
    ).thenAnswer((_) async => deviceMockInfo);

    when(
      () => getGlobalDeviceConfigurationRepository.call(
        identifier: any(named: 'identifier'),
      ),
    ).thenAnswer((_) async => globalDeviceConfigurationEntityMock);

    when(
      () => deviceConfigurationRepository.save(
        configuration: deviceConfigurationMock,
      ),
    ).thenAnswer((_) async => true);

    when(
      () => globalConfigurationRepository.saveEntity(
        globalConfigurationEntity: globalConfigurationEntityMock,
      ),
    ).thenAnswer((_) async => true);

    when(
      () => deviceRepository.saveEntity(device: deviceEntityMock),
    ).thenAnswer((_) async => true);

    when(
      () => getAccessTokenUsecase.call(tokenType: TokenType.key),
    ).thenAnswer((_) async => 'token');

    when(
      () => initClockUsecase.call(),
    ).thenAnswer((_) async => {});

    getGlobalDeviceConfigurationUsecase =
        GetGlobalDeviceConfigurationUsecaseImpl(
      getGlobalDeviceConfigurationRepository:
          getGlobalDeviceConfigurationRepository,
      deviceConfigurationRepository: deviceConfigurationRepository,
      globalConfigurationRepository: globalConfigurationRepository,
      platformService: platformService,
      deviceRepository: deviceRepository,
      getAccessTokenUsecase: getAccessTokenUsecase,
      initClockUsecase: initClockUsecase,
      logService: logService,
    );
  });

  group('GetGlobalDeviceConfigurationUsecase', () {
    test('return null when no key registered test', () async {
      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => null);

      GlobalDeviceConfigurationEntity? globalDeviceConfigurationEntity =
          await getGlobalDeviceConfigurationUsecase.call();

      expect(
        globalDeviceConfigurationEntity,
        null,
      );
    });

    test('get global device configuration successfully test', () async {
      registerFallbackValue(DateTime.now());
      when(
        () => initClockUsecase.call(
          initialDateTimeUTC: any(named: 'initialDateTimeUTC'),
        ),
      ).thenAnswer((_) async => {});

      GlobalDeviceConfigurationEntity? globalDeviceConfigurationEntity =
          await getGlobalDeviceConfigurationUsecase.call();

      expect(
        globalDeviceConfigurationEntity,
        globalDeviceConfigurationEntityMock,
      );

      verify(() => platformService.getDeviceInfoDto());

      verify(
        () => getGlobalDeviceConfigurationRepository.call(
          identifier: any(named: 'identifier'),
        ),
      );

      verify(
        () => deviceConfigurationRepository.save(
          configuration: deviceConfigurationMock,
        ),
      );

      verify(
        () => globalConfigurationRepository.saveEntity(
          globalConfigurationEntity: globalConfigurationEntityMock,
        ),
      );

      verify(
        () => deviceRepository.saveEntity(device: deviceEntityMock),
      );

      verify(
        () => initClockUsecase.call(
          initialDateTimeUTC: any(named: 'initialDateTimeUTC'),
        ),
      );

      verifyNoMoreInteractions(globalConfigurationRepository);
      verifyNoMoreInteractions(deviceConfigurationRepository);
      verifyNoMoreInteractions(platformService);
      verifyNoMoreInteractions(deviceRepository);
      verifyNoMoreInteractions(initClockUsecase);
    });

    test('return null global device configuration test', () async {
      when(
        () => getGlobalDeviceConfigurationRepository.call(
          identifier: any(named: 'identifier'),
        ),
      ).thenAnswer((_) async => null);

      GlobalDeviceConfigurationEntity? globalDeviceConfigurationEntity =
          await getGlobalDeviceConfigurationUsecase.call();

      expect(globalDeviceConfigurationEntity, null);

      verify(() => platformService.getDeviceInfoDto());

      verify(
        () => getGlobalDeviceConfigurationRepository.call(
          identifier: any(named: 'identifier'),
        ),
      );

      verify(() => initClockUsecase.call());

      verifyNoMoreInteractions(globalConfigurationRepository);
      verifyNoMoreInteractions(platformService);
      verifyZeroInteractions(deviceConfigurationRepository);
      verifyZeroInteractions(deviceRepository);
      verifyNoMoreInteractions(initClockUsecase);
    });
  });
}
