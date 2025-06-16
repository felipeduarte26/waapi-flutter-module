// ignore_for_file: unused_local_variable

import 'package:bloc_test/bloc_test.dart';
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/clocking_event_use.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/network_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_use_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/device_info_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/synchronization_result.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/clocking_event_use_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/synchronization_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_receipt_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/timer/timer_state.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../app/collector/core/domain/usecases/get_global_device_configuration_usecase_test.dart';
import '../../../../mocks/employee_dto_mock.dart';
import '../../../../mocks/import_clocking_event_dto_mock.dart';

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

class MockPlatformService extends Mock implements IPlatformService {}

class MockInternalClockService extends Mock
    implements clock.IInternalClockService {}

class MockCreateClockingEventService extends Mock
    implements clock.ICreateClockingEventService {}

class MockIUtils extends Mock implements IUtils {}

class MockEnvironmentService extends Mock implements IEnvironmentService {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockSynchronizeClockingEventService extends Mock
    implements ISynchronizeClockingEventService {}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

class MockClockingEventBloc
    extends MockBloc<ClockingEventEvent, ClockingEventBaseState>
    implements ClockingEventBloc {}

class MockGetReceiptUsecase extends Mock implements IGetReceiptUsecase {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

class PackageInfoMock extends Fake implements PackageInfo {
  @override
  String version;
  PackageInfoMock({this.version = '1.0'});
}

class FakeClockingEventInformationDto extends Fake
    implements clock.ClockingEventInformationDto {}

class FakeCompanyDto extends Fake implements clock.CompanyDto {}

class FakeEmployeeDto extends Fake implements clock.EmployeeDto {}

class FakeDeviceDto extends Fake implements clock.DeviceDto {}

class FakeLoginConfigurationDTO extends Fake
    implements auth.LoginConfigurationDTO {
  @override
  final String timezone;

  FakeLoginConfigurationDTO({required this.timezone});
}

class MockClockingEventUseRepository extends Mock
    implements ClockingEventUseRepository {}

void main() {
  late IRegisterClockingEventService registerClockingEventService;
  late IClockingEventRepository clockingEventRepository;
  late clock.ICreateClockingEventService createClockingEventService;
  late IEnvironmentService environmentService;
  late clock.IInternalClockService internalClockService;
  late IPlatformService platformService;
  late ISynchronizeClockingEventService synchronizeClockingEventService;
  late IUtils utils;
  late IConfigurationRepository configurationRepository;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late GetAccessTokenUsecase getAccessTokenUsecase;
  late ClockingEventUseRepository clockingEventUseRepository;
  late LogService logServiceRespository;

  DateTime dateTime = DateTime.parse('2023-05-12 10:37:21');

  const loginConfiguration = Configuration(
    onlyOnline: true,
    operationMode: OperationModeType.single,
    takePhoto: true,
    timezone: '-03:00',
  );

  StateLocationEntity locationModel = StateLocationEntity(
    hasPermission: true,
    isServiceEnabled: true,
    success: true,
    isMock: false,
    latitude: 10,
    longitude: 15,
  );

  StatePhotoEntity statePhotoModel = StatePhotoEntity(
    hasPermission: true,
    success: true,
    name: 'name.jpg',
  );

  clock.CompanyDto companyDto = clock.CompanyDto(
    name: 'Company Name',
    identifier: '05440988000123',
    timeZone: '-03:00',
    id: '3d650591-ca06-43f5-be9f-e22406163cc5',
  );

  clock.EmployeeDto employeeDto = clock.EmployeeDto(
    cpf: '62132285004',
    id: '8abbfa1f-cd9f-415c-87f4-daf94bf6bdd1',
    name: 'Employee Name',
    mail: 'employee@email.com.br',
    registrationNumber: '123',
    employeeType: 'COMPANY',
    company: companyDto,
  );

  DeviceInfo deviceInfo = DeviceInfo(
    identifier: '9ed66fde-fe99-4063-b4fb-0f8f40461336',
    model: 'Emulador',
    name: 'emux86',
  );

  PackageInfoMock packageInfoMock = PackageInfoMock();

  clock.ImportClockingEventDto clockingEvent = clock.ImportClockingEventDto(
    appVersion: packageInfoMock.version,
    companyIdentifier: companyDto.identifier,
    cpf: employeeDto.cpf,
    employeeId: employeeDto.id,
    platform: 'android',
    signature: '123',
    timeZone: '-03:00',
    use: 1,
    clockingEventId: 'dc0a7df2-1433-4800-8916-58c92ba9f6b5',
    dateEvent: '2022-11-16',
    timeEvent: '17:26:27',
    signatureVersion: 2,
    geolocationIsMock: false,
    isSynchronized: false,
    appointmentImage: 'photo_name.jpg',
    journeyId: '12345',
    isMealBreak: false,
  );

  DateTime dateTimeThatClockingEventProcessStarted = DateTime.now();

  setUpAll(() {
    registerFallbackValue(FakeClockingEventInformationDto());
    registerFallbackValue(FakeCompanyDto());
    registerFallbackValue(FakeEmployeeDto());
    registerFallbackValue(FakeDeviceDto());
  });

  setUp(
    () {
      clockingEventRepository = MockClockingEventRepository();
      createClockingEventService = MockCreateClockingEventService();
      environmentService = MockEnvironmentService();
      internalClockService = MockInternalClockService();
      platformService = MockPlatformService();
      synchronizeClockingEventService = MockSynchronizeClockingEventService();
      utils = MockIUtils();
      configurationRepository = MockConfigurationRepository();
      getExecutionModeUsecase = MockGetExecutionModeUsecase();
      getAccessTokenUsecase = MockGetAccessTokenUsecase();
      clockingEventUseRepository = MockClockingEventUseRepository();
      logServiceRespository  = MockLogService();

      registerClockingEventService = RegisterClockingEventService(
        clockingEventRepository: clockingEventRepository,
        createClockingEventService: createClockingEventService,
        environmentService: environmentService,
        internalClockService: internalClockService,
        platformService: platformService,
        synchronizeClockingEventService: synchronizeClockingEventService,
        utils: utils,
        configurationRepository: configurationRepository,
        getAccessTokenUsecase: getAccessTokenUsecase,
        clockingEventUseRepository: clockingEventUseRepository,
        logService: logServiceRespository,
      );

      registerFallbackValue(ClockingEventRegisterTypeSession());

      when(
        () => platformService.connectivityStatus(),
      ).thenAnswer(
        (invocation) => Future.value(NetworkStatusEnum.active),
      );

      when(
        () => utils.getOperationModeEnum(
          registerType: any(named: 'registerType'),
        ),
      ).thenReturn(OperationModeType.single);

      when(() => getExecutionModeUsecase.call())
          .thenAnswer((_) async => ExecutionModeEnum.individual);

      ClockingEventUseDto clockingEventUseDTO = ClockingEventUseDto(
        code: '1',
        description: 'Teste',
        employeeId: employeeDto.id,
        clockingEventUseType: ClockingEventUseType.clockingEvent,
      );
      ClockingEventUse clockingEventUseEntity = ClockingEventUse(
        code: '1',
        description: 'Teste',
        employeeId: employeeDto.id,
        clockingEventUseType: ClockingEventUseType.clockingEvent,
      );


      when(
        () => platformService.isTimeAuto(),
      ).thenAnswer(
        (invocation) => Future.value(true),
      );

      when(
        () => configurationRepository.findByEmployeeId(
          employeeId: employeeMockDto.id,
        ),
      ).thenAnswer((_) async => loginConfiguration);

      when(
        () => clockingEventUseRepository.findAllByEmployeeId(
          employeeId: employeeMockDto.id,
        ),
      ).thenAnswer((invocation) => Future.value([clockingEventUseEntity]));

      when(
        () => platformService.isTimeZoneAuto(),
      ).thenAnswer(
        (invocation) => Future.value(true),
      );

      when(
        () => platformService.getPlatformDevice(),
      ).thenReturn(clock.PlatformDeviceEnum.android);

      when(
        () => platformService.getPackageinfo(),
      ).thenAnswer((invocation) => Future.value(packageInfoMock));

      when(
        () => platformService.getDeviceInfoDto(),
      ).thenAnswer(
        (invocation) => Future.value(deviceInfo),
      );

      when(
        () => platformService.isDevelopmentDevice(),
      ).thenAnswer(
        (invocation) => Future.value(false),
      );

      when(
        () => internalClockService.getClockDateTime(),
      ).thenReturn(
        dateTime,
      );

      when(
        () => utils.createPhotoPath(
          employeeId: any(named: 'employeeId'),
          photoName: any(named: 'photoName'),
        ),
      ).thenAnswer(
        (invocation) => Future.value('path'),
      );

      when(
        () => utils.formatTime(
          dateTime: any(named: 'dateTime'),
          locale: any(named: 'locale'),
        ),
      ).thenReturn(
        '17:26',
      );

      when(
        () => utils.formatCPF(
          cpf: any(named: 'cpf'),
        ),
      ).thenReturn(
        '000.000.000-00',
      );

      when(
        () => utils.formatCNPJ(
          cnpj: any(named: 'cnpj'),
        ),
      ).thenReturn(
        '00.000.000/0001-00',
      );

      when(
        () => createClockingEventService.createClockingEvent(
          clockInfo: any(named: 'clockInfo'),
          dateTimeThatClockingEventProcessStarted:
              dateTimeThatClockingEventProcessStarted,
          company: any(named: 'company'),
          employee: any(named: 'employee'),
          device: any(named: 'device'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(clockingEvent),
      );

      when(
        () => environmentService.environment(),
      ).thenReturn(EnvironmentEnum.test);
      registerFallbackValue(importClockingEventDtoMock);

      when(
        () => getAccessTokenUsecase.call(),
      ).thenAnswer((_) async => 'token');
    },
  );

  test('RegisterClockingEventService Test', () async {
    initializeDateFormatting();

    ClockingEventRegisterEntity clockingEventRegisterEntity =
        ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: dateTimeThatClockingEventProcessStarted,
      employeeDto: employeeMockDto,
      location: locationModel,
      photo: statePhotoModel,
      successFacialRecognition: false,
    );

      when(
        () => clockingEventRepository.save(
          clockingEvent: any(named: 'clockingEvent'),
          isMealBreak: any(named: 'isMealBreak'),
          journeyEventName: any(named: 'journeyEventName'),
          journeyId: any(named: 'journeyId'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(true),
      );

    when(
        () => synchronizeClockingEventService.startSynchronize(),
      ).thenAnswer(
        (invocation) => Future.value(
          SynchronizationResult(
            SynchronizationStatus.success,
            SynchronizationMessage.syncClockingEventSyncSuccess,
          ),
        ),
      );

    await registerClockingEventService.register(
      clockingEventRegisterEntity: clockingEventRegisterEntity,
    );

    verify(
      () => platformService.getPlatformDevice(),
    ).called(1);

    verify(
      () => platformService.getPackageinfo(),
    ).called(1);

    verify(
      () => platformService.connectivityStatus(),
    ).called(1);

    verify(
      () => platformService.isTimeAuto(),
    ).called(1);

    verify(
      () => platformService.isTimeZoneAuto(),
    ).called(1);

    verify(
      () => platformService.getDeviceInfoDto(),
    ).called(1);

    verify(
      () => createClockingEventService.createClockingEvent(
        dateTimeThatClockingEventProcessStarted:
            dateTimeThatClockingEventProcessStarted,
        clockInfo: any(named: 'clockInfo'),
        company: any(named: 'company'),
        employee: any(named: 'employee'),
        device: any(named: 'device'),
      ),
    ).called(1);

    verify(
      () => clockingEventRepository.save(
        clockingEvent: any(named: 'clockingEvent'),
        isMealBreak: any(named: 'isMealBreak'),
        journeyEventName: any(named: 'journeyEventName'),
        journeyId: any(named: 'journeyId'),
      ),
    ).called(1);

    verify(
      () => synchronizeClockingEventService.startSynchronize(),
    ).called(1);

    verify(
      () => internalClockService.getClockDateTime(),
    ).called(1);

    verify(
      () => utils.createPhotoPath(
        employeeId: any(named: 'employeeId'),
        photoName: any(named: 'photoName'),
      ),
    ).called(2);

    verify(
      () => utils.getOperationModeEnum(
        registerType: any(named: 'registerType'),
      ),
    ).called(1);

    verify(
      () => environmentService.environment(),
    ).called(1);

    verify(
      () => platformService.isDevelopmentDevice(),
    ).called(1);

    verify(
      () => configurationRepository.findByEmployeeId(
        employeeId: employeeMockDto.id,
      ),
    ).called(1);

    verify(
      () => getAccessTokenUsecase.call(),
    ).called(1);

    verifyNoMoreInteractions(platformService);
    verifyNoMoreInteractions(createClockingEventService);
    verifyNoMoreInteractions(clockingEventRepository);
    verifyNoMoreInteractions(synchronizeClockingEventService);
    verifyNoMoreInteractions(internalClockService);
    verifyNoMoreInteractions(utils);
    verifyNoMoreInteractions(environmentService);
    verifyNoMoreInteractions(configurationRepository);
    verifyNoMoreInteractions(getAccessTokenUsecase);
  });

  test(
    'EmailPassword register type success Test',
    () async {
      initializeDateFormatting();

      ClockingEventRegisterEntity clockingEventRegisterEntity =
          ClockingEventRegisterEntity(
        clockingEventRegisterType: ClockingEventRegisterTypeEmailPassword(
          employeeId: 'employeeId',
        ),
        dateTime: dateTimeThatClockingEventProcessStarted,
        employeeDto: employeeMockDto,
        location: locationModel,
        photo: statePhotoModel,
        successFacialRecognition: false,
      );

      when(
        () => clockingEventRepository.save(
          clockingEvent: any(named: 'clockingEvent'),
          isMealBreak: any(named: 'isMealBreak'),
          journeyEventName: any(named: 'journeyEventName'),
          journeyId: any(named: 'journeyId'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(true),
      );

      when(
        () => synchronizeClockingEventService.startSynchronize(),
      ).thenAnswer(
        (invocation) => Future.value(
          SynchronizationResult(
            SynchronizationStatus.success,
            SynchronizationMessage.syncClockingEventSyncSuccess,
          ),
        ),
      );

      await registerClockingEventService.register(
        clockingEventRegisterEntity: clockingEventRegisterEntity,
      );

      verify(
        () => platformService.getPlatformDevice(),
      ).called(1);

      verify(
        () => platformService.getPackageinfo(),
      ).called(1);

      verify(
        () => platformService.connectivityStatus(),
      ).called(1);

      verify(
        () => platformService.isTimeAuto(),
      ).called(1);

      verify(
        () => platformService.isTimeZoneAuto(),
      ).called(1);

      verify(
        () => platformService.getDeviceInfoDto(),
      ).called(1);

      verify(
        () => createClockingEventService.createClockingEvent(
          dateTimeThatClockingEventProcessStarted:
              dateTimeThatClockingEventProcessStarted,
          clockInfo: any(named: 'clockInfo'),
          company: any(named: 'company'),
          employee: any(named: 'employee'),
          device: any(named: 'device'),
        ),
      ).called(1);

      verify(
        () => clockingEventRepository.save(
          clockingEvent: any(named: 'clockingEvent'),
          isMealBreak: any(named: 'isMealBreak'),
          journeyEventName: any(named: 'journeyEventName'),
          journeyId: any(named: 'journeyId'),
        ),
      ).called(1);

      verify(
        () => synchronizeClockingEventService.startSynchronize(),
      ).called(1);

      verify(
        () => internalClockService.getClockDateTime(),
      ).called(1);

      verify(
        () => utils.createPhotoPath(
          employeeId: any(named: 'employeeId'),
          photoName: any(named: 'photoName'),
        ),
      ).called(2);

      verify(
        () => utils.getOperationModeEnum(
          registerType: any(named: 'registerType'),
        ),
      ).called(1);

      verify(
        () => environmentService.environment(),
      ).called(1);

      verify(
        () => platformService.isDevelopmentDevice(),
      ).called(1);

      verify(
        () => configurationRepository.findByEmployeeId(
          employeeId: employeeMockDto.id,
        ),
      ).called(1);

      verify(
        () => getAccessTokenUsecase.call(),
      ).called(1);

      verifyNoMoreInteractions(platformService);
      verifyNoMoreInteractions(createClockingEventService);
      verifyNoMoreInteractions(clockingEventRepository);
      verifyNoMoreInteractions(synchronizeClockingEventService);
      verifyNoMoreInteractions(internalClockService);
      verifyNoMoreInteractions(utils);
      verifyNoMoreInteractions(environmentService);
      verifyNoMoreInteractions(configurationRepository);
      verifyNoMoreInteractions(getAccessTokenUsecase);
    },
  );

test(
  'Throws error on startSynchronize with EmailPassword register type Test',
  () async {
    initializeDateFormatting();

    ClockingEventRegisterEntity clockingEventRegisterEntity =
        ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeEmailPassword(
        employeeId: 'employeeId',
      ),
      dateTime: dateTimeThatClockingEventProcessStarted,
      employeeDto: employeeMockDto,
      location: locationModel,
      photo: statePhotoModel,
      successFacialRecognition: false,
    );

    when(
      () => clockingEventRepository.save(
        clockingEvent: any(named: 'clockingEvent'),
        isMealBreak: any(named: 'isMealBreak'),
        journeyEventName: any(named: 'journeyEventName'),
        journeyId: any(named: 'journeyId'),
      ),
    ).thenAnswer(
      (invocation) => Future.value(true),
    );

    when(
      () => synchronizeClockingEventService.startSynchronize(),
    ).thenThrow('error on startSynchronize');

    // Verifica se a exceção foi lançada
    expect(
      () async => await registerClockingEventService.register(
        clockingEventRegisterEntity: clockingEventRegisterEntity,
      ),
      throwsA('error on startSynchronize'),
    );
  },
);

  test('RegisterClockingEventService with error on startSynchronize Test', () async {
    initializeDateFormatting();

    ClockingEventRegisterEntity clockingEventRegisterEntity =
        ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: dateTimeThatClockingEventProcessStarted,
      employeeDto: employeeMockDto,
      location: locationModel,
      photo: statePhotoModel,
      successFacialRecognition: false,
    );

    when(
        () => clockingEventRepository.save(
          clockingEvent: any(named: 'clockingEvent'),
          isMealBreak: any(named: 'isMealBreak'),
          journeyEventName: any(named: 'journeyEventName'),
          journeyId: any(named: 'journeyId'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(true),
    );
    
    when(
        () => synchronizeClockingEventService.startSynchronize(),
      ).thenAnswer(
        (invocation) => Future.value(
          SynchronizationResult(
            SynchronizationStatus.error,
            SynchronizationMessage.syncClockingEventSyncFailure,
          ),
        ),
      );

    await registerClockingEventService.register(
      clockingEventRegisterEntity: clockingEventRegisterEntity,
    );

    verify(
      () => platformService.getPlatformDevice(),
    ).called(1);

    verify(
      () => platformService.getPackageinfo(),
    ).called(1);

    verify(
      () => platformService.connectivityStatus(),
    ).called(1);

    verify(
      () => platformService.isTimeAuto(),
    ).called(1);

    verify(
      () => platformService.isTimeZoneAuto(),
    ).called(1);

    verify(
      () => platformService.getDeviceInfoDto(),
    ).called(1);

    verify(
      () => createClockingEventService.createClockingEvent(
        dateTimeThatClockingEventProcessStarted:
            dateTimeThatClockingEventProcessStarted,
        clockInfo: any(named: 'clockInfo'),
        company: any(named: 'company'),
        employee: any(named: 'employee'),
        device: any(named: 'device'),
      ),
    ).called(1);

    verify(
      () => clockingEventRepository.save(
        clockingEvent: any(named: 'clockingEvent'),
        isMealBreak: any(named: 'isMealBreak'),
        journeyEventName: any(named: 'journeyEventName'),
        journeyId: any(named: 'journeyId'),
      ),
    ).called(1);

    verify(
      () => synchronizeClockingEventService.startSynchronize(),
    ).called(1);

    verify(
      () => internalClockService.getClockDateTime(),
    ).called(1);

    verify(
      () => utils.createPhotoPath(
        employeeId: any(named: 'employeeId'),
        photoName: any(named: 'photoName'),
      ),
    ).called(2);

    verify(
      () => utils.getOperationModeEnum(
        registerType: any(named: 'registerType'),
      ),
    ).called(1);

    verify(
      () => environmentService.environment(),
    ).called(1);

    verify(
      () => platformService.isDevelopmentDevice(),
    ).called(1);

    verify(
      () => configurationRepository.findByEmployeeId(
        employeeId: employeeMockDto.id,
      ),
    ).called(1);

    verify(
      () => getAccessTokenUsecase.call(),
    ).called(1);

    verifyNoMoreInteractions(platformService);
    verifyNoMoreInteractions(createClockingEventService);
    verifyNoMoreInteractions(clockingEventRepository);
    verifyNoMoreInteractions(synchronizeClockingEventService);
    verifyNoMoreInteractions(internalClockService);
    verifyNoMoreInteractions(utils);
    verifyNoMoreInteractions(environmentService);
    verifyNoMoreInteractions(configurationRepository);
    verifyNoMoreInteractions(getAccessTokenUsecase);
  });

  test('RegisterClockingEventService when save on clockingEventRepository return false Test', () async {
    initializeDateFormatting();

    ClockingEventRegisterEntity clockingEventRegisterEntity =
        ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: dateTimeThatClockingEventProcessStarted,
      employeeDto: employeeMockDto,
      location: locationModel,
      photo: statePhotoModel,
      successFacialRecognition: false,
    );

    when(
        () => clockingEventRepository.save(
          clockingEvent: any(named: 'clockingEvent'),
          isMealBreak: any(named: 'isMealBreak'),
          journeyEventName: any(named: 'journeyEventName'),
          journeyId: any(named: 'journeyId'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(false),
      );

    when(
        () => synchronizeClockingEventService.startSynchronize(),
      ).thenAnswer(
        (invocation) => Future.value(
          SynchronizationResult(
            SynchronizationStatus.error,
            SynchronizationMessage.syncClockingEventSyncFailure,
          ),
        ),
      );

    await registerClockingEventService.register(
      clockingEventRegisterEntity: clockingEventRegisterEntity,
    );

    verify(
      () => platformService.getPlatformDevice(),
    ).called(1);

    verify(
      () => platformService.getPackageinfo(),
    ).called(1);

    verify(
      () => platformService.connectivityStatus(),
    ).called(1);

    verify(
      () => platformService.isTimeAuto(),
    ).called(1);

    verify(
      () => platformService.isTimeZoneAuto(),
    ).called(1);

    verify(
      () => platformService.getDeviceInfoDto(),
    ).called(1);

    verify(
      () => createClockingEventService.createClockingEvent(
        dateTimeThatClockingEventProcessStarted:
            dateTimeThatClockingEventProcessStarted,
        clockInfo: any(named: 'clockInfo'),
        company: any(named: 'company'),
        employee: any(named: 'employee'),
        device: any(named: 'device'),
      ),
    ).called(1);

    verify(
      () => clockingEventRepository.save(
        clockingEvent: any(named: 'clockingEvent'),
        isMealBreak: any(named: 'isMealBreak'),
        journeyEventName: any(named: 'journeyEventName'),
        journeyId: any(named: 'journeyId'),
      ),
    ).called(1);

    verify(
      () => synchronizeClockingEventService.startSynchronize(),
    ).called(1);

    verify(
      () => internalClockService.getClockDateTime(),
    ).called(1);

    verify(
      () => utils.createPhotoPath(
        employeeId: any(named: 'employeeId'),
        photoName: any(named: 'photoName'),
      ),
    ).called(2);

    verify(
      () => utils.getOperationModeEnum(
        registerType: any(named: 'registerType'),
      ),
    ).called(1);

    verify(
      () => environmentService.environment(),
    ).called(1);

    verify(
      () => platformService.isDevelopmentDevice(),
    ).called(1);

    verify(
      () => configurationRepository.findByEmployeeId(
        employeeId: employeeMockDto.id,
      ),
    ).called(1);

    verify(
      () => getAccessTokenUsecase.call(),
    ).called(1);

    verifyNoMoreInteractions(platformService);
    verifyNoMoreInteractions(createClockingEventService);
    verifyNoMoreInteractions(clockingEventRepository);
    verifyNoMoreInteractions(synchronizeClockingEventService);
    verifyNoMoreInteractions(internalClockService);
    verifyNoMoreInteractions(utils);
    verifyNoMoreInteractions(environmentService);
    verifyNoMoreInteractions(configurationRepository);
    verifyNoMoreInteractions(getAccessTokenUsecase);
  });
}
