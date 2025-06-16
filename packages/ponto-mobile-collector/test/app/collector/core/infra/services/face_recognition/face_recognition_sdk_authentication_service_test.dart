import 'dart:async';

import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/facial_recognition_message.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/work_indicator_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_check_face_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_register_company_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_authenticate_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_download_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_settings_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_synchronization_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/work_indicator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/face_recognition/face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../mocks/employee_dto_mock.dart';

final _tMessages = [
  const FacialRecognitionMessage(
    message: 'Authenticated',
    code: 100,
    status: 'success',
    method: 'authenticate',
  ),
  const FacialRecognitionMessage(
    message: 'Downloaded Files',
    code: 100,
    status: 'success',
    method: 'downloadWeights',
  ),
];

class MockFaceRecognitionAuthenticateService extends Mock
    implements FaceRecognitionAuthenticateService {}

class MockFaceRecognitionDownloadService extends Mock
    implements FaceRecognitionDownloadService {}

class MockFaceRecognitionRegisterCompanyRepository extends Mock
    implements FaceRecognitionRegisterCompanyRepository {}

class MockFaceRecognitionSynchronizationService extends Mock
    implements FaceRecognitionSynchronizationService {}

class MockFaceRecognitionCheckFaceRepository extends Mock
    implements FaceRecognitionCheckFaceRepository {}

class MockWorkIndicatorService extends Mock implements WorkIndicatorService {}

class MockHasConnectivityUsecase extends Mock
    implements HasConnectivityUsecase {}

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {
  // Create a StreamController
  final StreamController<Map> _recognizeEventStreamController =
      StreamController<Map>();

  @override
  Stream<Map> get onMessage async* {
    for (var message in _tMessages) {
      yield message.toMap();
    }
  }

  @override
  StreamController get recognizeEventStream => _recognizeEventStreamController;

  // Add a method to add events to the stream
  void addRecognizeEvent(Map event) {
    _recognizeEventStreamController.add(event);
  }

  // Don't forget to close the StreamController
  void dispose() {
    _recognizeEventStreamController.close();
  }
}

class MockIPermissionService extends Mock implements IPermissionService {}

class MockISharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

class MockISessionService extends Mock implements ISessionService {}

class MockFaceRecognitionSettingsService extends Mock
    implements FaceRecognitionSettingsService {}

void main() {
  String tEmployeeId = employeeDtoMock.id;
  const String tCompanyId = 'tCompanyId';
  Map<String, dynamic> mapRegistered = {
    'external_ids': '["id"]',
  };

  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  late FaceRecognitionAuthenticateService faceRecognitionAuthenticateService;
  late FaceRecognitionDownloadService faceRecognitionDownloadService;
  late FaceRecognitionRegisterCompanyRepository
      faceRecognitionRegisterCompanyRepository;
  late FaceRecognitionSynchronizationService
      faceRecognitionSynchronizationService;
  late FlutterGryfoLib flutterGryfoLib;
  late IPermissionService permissionService;
  late ISessionService sessionService;
  late FaceRecognitionSettingsService faceRecognitionSettingsService;
  late FaceRecognitionCheckFaceRepository faceRecognitionCheckFaceRepository;
  late ISharedPreferencesService sharedPreferencesService;
  late GetTokenUsecase getTokenUsecase;
  late WorkIndicatorService workIndicatorService;
  late HasConnectivityUsecase hasConnectivityUsecase;

  setUp(() {
    faceRecognitionAuthenticateService =
        MockFaceRecognitionAuthenticateService();
    faceRecognitionDownloadService = MockFaceRecognitionDownloadService();
    faceRecognitionRegisterCompanyRepository =
        MockFaceRecognitionRegisterCompanyRepository();
    faceRecognitionSynchronizationService =
        MockFaceRecognitionSynchronizationService();
    flutterGryfoLib = MockFlutterGryfoLib();
    permissionService = MockIPermissionService();
    sessionService = MockISessionService();
    faceRecognitionSettingsService = MockFaceRecognitionSettingsService();
    faceRecognitionCheckFaceRepository =
        MockFaceRecognitionCheckFaceRepository();
    sharedPreferencesService = MockISharedPreferencesService();
    getTokenUsecase = MockGetTokenUsecase();
    workIndicatorService = MockWorkIndicatorService();
    hasConnectivityUsecase = MockHasConnectivityUsecase();

    faceRecognitionSdkAuthenticationService =
        FaceRecognitionSdkAuthenticationService(
      faceRecognitionAuthenticateService: faceRecognitionAuthenticateService,
      faceRecognitionDownloadService: faceRecognitionDownloadService,
      faceRecognitionRegisterCompanyRepository:
          faceRecognitionRegisterCompanyRepository,
      faceRecognitionSynchronizationService:
          faceRecognitionSynchronizationService,
      gryfoLib: flutterGryfoLib,
      permissionService: permissionService,
      sessionService: sessionService,
      settingsService: faceRecognitionSettingsService,
      faceRecognitionCheckFaceRepository: faceRecognitionCheckFaceRepository,
      sharedPreferencesService: sharedPreferencesService,
      getTokenUsecase: getTokenUsecase,
      workIndicatorService: workIndicatorService,
      hasConnectivityUsecase: hasConnectivityUsecase,
    );

    when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

    when(
      () => flutterGryfoLib.getRegistered(),
    ).thenAnswer((_) async => mapRegistered);

    when(
      () => permissionService.requestDevicePermissionIfNotAllowed(
        permission: DevicePermissionEnum.camera,
      ),
    ).thenAnswer((_) async => true);

    when(
      () => sessionService.getCompanyId(),
    ).thenReturn(tCompanyId);

    when(
      () => sessionService.hasEmployee(),
    ).thenReturn(true);

    when(
      () => sessionService.getEmployeeId(),
    ).thenReturn(tEmployeeId);

    when(
      () => sessionService.getEmployee(),
    ).thenReturn(employeeMockDto);

    when(
      () => sessionService.setFaceRegistered(
        id: employeeDtoMock.faceRegistered!,
      ),
    ).thenReturn(null);

    when(
      () => faceRecognitionSettingsService.setSettings(),
    ).thenAnswer(
      (_) async => true,
    );

    when(
      () => faceRecognitionRegisterCompanyRepository.call(
        companyId: tCompanyId,
      ),
    ).thenAnswer(
      (_) async => true,
    );

    when(
      () => faceRecognitionAuthenticateService.authenticate(),
    ).thenAnswer(
      (_) async => true,
    );

    when(
      () => faceRecognitionDownloadService.downloadAIFiles(),
    ).thenAnswer(
      (_) async => true,
    );

    when(
      () => faceRecognitionSynchronizationService.syncFaceEmployee(tEmployeeId),
    ).thenAnswer((_) async => true);

    when(
      () => faceRecognitionCheckFaceRepository.call(employeeId: tEmployeeId),
    ).thenAnswer((_) async => false);

    when(
      () => getTokenUsecase.call(tokenType: TokenType.key),
    ).thenAnswer((_) async => null);

    when(
      () => sharedPreferencesService.setSessionCompanyId(
        companyId: tCompanyId,
      ),
    ).thenAnswer((_) async => {});

    when(
      () => sharedPreferencesService.getSessionCompanyId(),
    ).thenAnswer((_) async => '');

    when(
      () => workIndicatorService.addWorkIndicator(
        workIndicatorType: WorkIndicatorType.faceRecognitionInitialize,
      ),
    ).thenReturn(true);

    when(
      () => workIndicatorService.removeWorkIndicator(
        workIndicatorType: WorkIndicatorType.faceRecognitionInitialize,
      ),
    ).thenReturn(true);
  });

  void mockVerifyNoMoreInteractions() {
    verifyNoMoreInteractions(faceRecognitionAuthenticateService);
    verifyNoMoreInteractions(faceRecognitionDownloadService);
    verifyNoMoreInteractions(faceRecognitionRegisterCompanyRepository);
    verifyNoMoreInteractions(faceRecognitionSynchronizationService);
    verifyNoMoreInteractions(flutterGryfoLib);
    verifyNoMoreInteractions(permissionService);
    verifyNoMoreInteractions(sessionService);
    verifyNoMoreInteractions(faceRecognitionSettingsService);
  }

  group('FaceRecognitionSdkAuthenticationService', () {
    test('Should return Gryfo service', () async {
      expect(
        faceRecognitionSdkAuthenticationService.getGryfoService(),
        flutterGryfoLib,
      );
    });

    test(
      'call getFacialRecognitionMessageStream test',
      () async {
        Stream<FacialRecognitionMessage> response =
            faceRecognitionSdkAuthenticationService
                .getFacialRecognitionMessageStream();

        expect(
          response.runtimeType.toString(),
          '_BroadcastStream<FacialRecognitionMessage>',
        );
      },
    );

    test('getInitializeStream - success', () async {
      faceRecognitionSdkAuthenticationService.getInitializeStream();
    });

    test('initialize successfully teste', () async {
      await faceRecognitionSdkAuthenticationService.initialize(
        forceFaceSync: true,
      );

      verify(
        () => permissionService.requestDevicePermissionIfNotAllowed(
          permission: DevicePermissionEnum.camera,
        ),
      );

      verify(() => sessionService.getCompanyId());
      verify(() => sessionService.hasEmployee());
      verify(() => sessionService.getEmployeeId());
      verify(() => sessionService.getEmployee());
      verify(
        () => faceRecognitionSettingsService.setSettings(),
      );
      verify(
        () => faceRecognitionRegisterCompanyRepository.call(
          companyId: tCompanyId,
        ),
      );
      verify(() => faceRecognitionAuthenticateService.authenticate());
      verify(() => faceRecognitionDownloadService.downloadAIFiles());
      verify(
        () =>
            faceRecognitionSynchronizationService.syncFaceEmployee(tEmployeeId),
      );

      verify(
        () => workIndicatorService.addWorkIndicator(
          workIndicatorType: WorkIndicatorType.faceRecognitionInitialize,
        ),
      );

      verify(
        () => workIndicatorService.removeWorkIndicator(
          workIndicatorType: WorkIndicatorType.faceRecognitionInitialize,
        ),
      );

      verify(() => hasConnectivityUsecase.call());

      mockVerifyNoMoreInteractions();
    });

    test('not initialize when setSettings error test', () async {
      when(
        () => faceRecognitionSettingsService.setSettings(),
      ).thenAnswer(
        (_) async => false,
      );

      await faceRecognitionSdkAuthenticationService.initialize();

      verify(
        () => permissionService.requestDevicePermissionIfNotAllowed(
          permission: DevicePermissionEnum.camera,
        ),
      );

      verify(
        () => faceRecognitionSettingsService.setSettings(),
      );

      mockVerifyNoMoreInteractions();
    });

    test('not initialize when register company error test', () async {
      when(
        () => faceRecognitionRegisterCompanyRepository.call(
          companyId: tCompanyId,
        ),
      ).thenAnswer(
        (_) async => false,
      );

      when(
        () => faceRecognitionAuthenticateService.authenticate(),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => faceRecognitionDownloadService.downloadAIFiles(),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => sessionService.hasEmployee(),
      ).thenAnswer(
        (_) => true,
      );

      await faceRecognitionSdkAuthenticationService.initialize();

      verify(
        () => permissionService.requestDevicePermissionIfNotAllowed(
          permission: DevicePermissionEnum.camera,
        ),
      );

      verify(() => faceRecognitionAuthenticateService.authenticate());

      verify(() => faceRecognitionDownloadService.downloadAIFiles());

      verify(() => sessionService.hasEmployee());

      verify(() => sessionService.getCompanyId());
      verify(
        () => faceRecognitionSettingsService.setSettings(),
      );
      verify(
        () => faceRecognitionRegisterCompanyRepository.call(
          companyId: tCompanyId,
        ),
      );

      mockVerifyNoMoreInteractions();
    });

    test('not initialize when authentication error test', () async {
      when(
        () => faceRecognitionAuthenticateService.authenticate(),
      ).thenAnswer(
        (_) async => false,
      );

      await faceRecognitionSdkAuthenticationService.initialize();

      verify(
        () => permissionService.requestDevicePermissionIfNotAllowed(
          permission: DevicePermissionEnum.camera,
        ),
      );

      verify(
        () => faceRecognitionSettingsService.setSettings(),
      );

      verify(() => faceRecognitionAuthenticateService.authenticate());

      mockVerifyNoMoreInteractions();
    });

    test('not initialize when download IA files error test', () async {
      when(
        () => faceRecognitionDownloadService.downloadAIFiles(),
      ).thenAnswer(
        (_) async => false,
      );

      await faceRecognitionSdkAuthenticationService.initialize();

      verify(
        () => permissionService.requestDevicePermissionIfNotAllowed(
          permission: DevicePermissionEnum.camera,
        ),
      );

      verify(
        () => faceRecognitionSettingsService.setSettings(),
      );

      verify(() => faceRecognitionAuthenticateService.authenticate());
      verify(() => faceRecognitionDownloadService.downloadAIFiles());

      mockVerifyNoMoreInteractions();
    });
  });
}
