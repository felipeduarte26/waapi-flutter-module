import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/init_clock_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/configuration_entity_mock.dart';
import '../../../../mocks/device_configuration_mock.dart';
import '../../../../mocks/device_info_mock.dart';
import '../../../../mocks/employee_dto_mock.dart';

class MockSessionService extends Mock implements ISessionService {}

class MockInternalClockService extends Mock
    implements clock.IInternalClockService {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockDeviceConfigurationRepository extends Mock
    implements DeviceConfigurationRepository {}

class MockPlatformService extends Mock implements IPlatformService {}

class MockConfigurationRepository extends Mock implements ConfigurationRepository {}

void main() {
  late IInitClockUsecase initClockUsecase;
  late ISessionService sessionService;
  late clock.IInternalClockService internalClockService;
  late GetAccessTokenUsecase getAccessTokenUsecase;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late DeviceConfigurationRepository deviceConfigurationRepository;
  late IPlatformService platformService;
  late ConfigurationRepository configurationRepository;
  Duration timeZoneOffset = const Duration(minutes: -180);
  //clock.EmployeeDto employeeDto = clock.EmployeeDto(id: '1', name: 'employee 1', employeeType: 'COMPANY_EMPLOYEE', cpf: '12345678901');
  setUp(() {
    sessionService = MockSessionService();
    internalClockService = MockInternalClockService();
    getAccessTokenUsecase = MockGetAccessTokenUsecase();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    deviceConfigurationRepository = MockDeviceConfigurationRepository();
    platformService = MockPlatformService();
    configurationRepository = MockConfigurationRepository();

    initClockUsecase = InitClockUsecase(
      sessionService: sessionService,
      internalClockService: internalClockService,
      getAccessTokenUsecase: getAccessTokenUsecase,
      getExecutionModeUsecase: getExecutionModeUsecase,
      deviceConfigurationRepository: deviceConfigurationRepository,
      platformService: platformService,
      configurationRepository: configurationRepository,
    );
  });

  group('InitClockUsecase', () {
    test('start clock on individual mode successfully test.', () async {
      
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.individual);

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.user),
      ).thenAnswer((_) async => 'accessToken');

      when(
        () => sessionService.getTimeZoneOffset(),
      ).thenReturn(timeZoneOffset);

      when(
        () => internalClockService.initClock(
          requestServerDateTime: true,
          timeZoneOffset: timeZoneOffset,
        ),
      ).thenAnswer((invocation) => Future.value());

      when(() => sessionService.getEmployee(),
      ).thenReturn(employeeMockDto);

      when(() => configurationRepository.findByEmployeeId(employeeId: employeeMockDto.id),
      ).thenAnswer((_) async => Future<Configuration>(() => configurationEntityMock));

      await initClockUsecase.call();

      verify(
        () => sessionService.getTimeZoneOffset(),
      ).called(1);

      verify(
        () => sessionService.getEmployee(),
      ).called(1);

      verify(
        () => internalClockService.initClock(
          requestServerDateTime: true,
          timeZoneOffset: timeZoneOffset,
        ),
      ).called(1);

      verifyNoMoreInteractions(sessionService);
      verifyNoMoreInteractions(internalClockService);
    });

    test(
        'start clock with device configuration time zone '
        'in multiple mode successfully test.', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.multiple);

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => 'accessToken');

      when(
        () => sessionService.getTimeZoneOffset(),
      ).thenReturn(timeZoneOffset);

      when(
        () => internalClockService.initClock(
          requestServerDateTime: true,
          timeZoneOffset: timeZoneOffset,
        ),
      ).thenAnswer((invocation) => Future.value());

      when(
        () => platformService.getDeviceInfoDto(),
      ).thenAnswer(
        (_) async => deviceMockInfo,
      );

      when(
        () => deviceConfigurationRepository.findByIdentifier(
          identifier: deviceInfoMock.identifier,
        ),
      ).thenAnswer(
        (_) async => deviceConfigurationMock.copyWith(
          allowChangeTime: false,
          timeZone: 'America/Sao_Paulo',
        ),
      );

      await initClockUsecase.call();

      verify(() => getExecutionModeUsecase.call());
      verify(() => getAccessTokenUsecase.call(tokenType: TokenType.key));
      verify(
        () => internalClockService.initClock(
          requestServerDateTime: true,
          timeZoneOffset: timeZoneOffset,
        ),
      );
      verify(() => platformService.getDeviceInfoDto());
      verify(
        () => deviceConfigurationRepository.findByIdentifier(
          identifier: deviceInfoMock.identifier,
        ),
      );

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(getAccessTokenUsecase);
      verifyNoMoreInteractions(internalClockService);
      verifyNoMoreInteractions(platformService);
      verifyNoMoreInteractions(deviceConfigurationRepository);
    });

    test(
        'start clock with device date and time '
        'in multiple mode successfully test.', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.multiple);

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => 'accessToken');

      when(
        () => internalClockService.initClock(
          requestServerDateTime: false,
          timeZoneOffset: null,
          initialDateTimeUTC: null,
        ),
      ).thenAnswer((_) async => {});

      when(
        () => platformService.getDeviceInfoDto(),
      ).thenAnswer(
        (_) async => deviceMockInfo,
      );

      when(
        () => deviceConfigurationRepository.findByIdentifier(
          identifier: deviceInfoMock.identifier,
        ),
      ).thenAnswer(
        (_) async => deviceConfigurationMock.copyWith(
          allowChangeTime: true,
        ),
      );

      await initClockUsecase.call();

      verify(() => getExecutionModeUsecase.call());
      verify(() => getAccessTokenUsecase.call(tokenType: TokenType.key));
      verify(
        () => internalClockService.initClock(
          requestServerDateTime: false,
          timeZoneOffset: null,
          initialDateTimeUTC: null,
        ),
      );
      verify(() => platformService.getDeviceInfoDto());
      verify(
        () => deviceConfigurationRepository.findByIdentifier(
          identifier: deviceInfoMock.identifier,
        ),
      );

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(getAccessTokenUsecase);
      verifyNoMoreInteractions(internalClockService);
      verifyNoMoreInteractions(platformService);
      verifyNoMoreInteractions(deviceConfigurationRepository);
    });
  });
}
