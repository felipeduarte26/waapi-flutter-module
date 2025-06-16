@Timeout(Duration(minutes: 1))
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/work_indicator_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/synchronization_result.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_check_face_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_register_company_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/work_indicator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_face_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/synchronization_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/employee_dto_mock.dart';

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

class MockFaceRecognitionCheckFaceRepository extends Mock
    implements FaceRecognitionCheckFaceRepository {}

class MockFaceRecognitionRegisterCompanyRepository extends Mock
    implements FaceRecognitionRegisterCompanyRepository {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockSessionService extends Mock implements ISessionService {}

class MockWorkIndicatorService extends Mock implements WorkIndicatorService {}

void main() {
  const String tEmployeeId = '83e1a9c811ec4f8b8a923f22782b4f9f';
  const String tCompanyId = 'tCompanyId';
  late ISyncFaceEmployeeUsecase syncFaceEmployeeUsecase;
  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  late ISharedPreferencesService sharedPreferencesService;
  late ISessionService sessionService;
  late FaceRecognitionCheckFaceRepository faceRecognitionCheckFaceRepository;
  late FaceRecognitionRegisterCompanyRepository
      faceRecognitionRegisterCompanyRepository;
  late WorkIndicatorService workIndicatorService;

  setUp(() {
    faceRecognitionSdkAuthenticationService =
        MockFaceRecognitionSdkAuthenticationService();

    sharedPreferencesService = MockSharedPreferencesService();
    sessionService = MockSessionService();
    faceRecognitionCheckFaceRepository =
        MockFaceRecognitionCheckFaceRepository();
    faceRecognitionRegisterCompanyRepository =
        MockFaceRecognitionRegisterCompanyRepository();
    workIndicatorService = MockWorkIndicatorService();

    syncFaceEmployeeUsecase = SyncFaceEmployeeUsecase(
      faceRecognitionSdkAuthenticationService:
          faceRecognitionSdkAuthenticationService,
      sharedPreferencesService: sharedPreferencesService,
      sessionService: sessionService,
      faceRecognitionCheckFaceRepository: faceRecognitionCheckFaceRepository,
      faceRecognitionRegisterCompanyRepository:
          faceRecognitionRegisterCompanyRepository,
      workIndicatorService: workIndicatorService,
    );

    when(
      () => workIndicatorService.addWorkIndicator(
        workIndicatorType: WorkIndicatorType.syncFaceEmployeeUsecase,
      ),
    ).thenReturn(true);

    when(
      () => workIndicatorService.removeWorkIndicator(
        workIndicatorType: WorkIndicatorType.syncFaceEmployeeUsecase,
      ),
    ).thenReturn(true);

    when(
      () => faceRecognitionCheckFaceRepository.call(
        employeeId: tEmployeeId,
      ),
    ).thenAnswer((_) async => false);

    when(
      () => sharedPreferencesService.getFacialRecognitionAuthentication(
        companyId: tCompanyId,
      ),
    ).thenAnswer((_) async => true);

    when(() => sessionService.hasEmployee()).thenReturn(true);
    when(() => sessionService.getEmployeeId()).thenReturn(tEmployeeId);
    when(() => sessionService.getCompanyId()).thenReturn(tCompanyId);
    when(() => sessionService.getEmployee()).thenReturn(employeeMockDto);

    when(
      () => faceRecognitionSdkAuthenticationService.initialize(
        delayToInit: const Duration(seconds: 30),
      ),
    ).thenAnswer((_) async {});
  });

  group('RegisterFaceEmployeeUsecase', () {
    test('should return success if no face registered test', () async {
      when(() => sessionService.getEmployee())
          .thenReturn(employeeNoFaceMockDto);

      SynchronizationResult synchronizationResult =
          await syncFaceEmployeeUsecase.call();
      expect(synchronizationResult.status, SynchronizationStatus.success);
      expect(
        synchronizationResult.message,
        SynchronizationMessage.noFaceRegistered,
      );
    });

    test('should sync biometric face successfully test', () async {
      var synchronizationResult = await syncFaceEmployeeUsecase.call();
      expect(synchronizationResult.status, SynchronizationStatus.success);

      verify(() => sessionService.getEmployeeId());
      verify(() => sessionService.getEmployee()).called(2);

      verify(
        () => faceRecognitionSdkAuthenticationService.initialize(
          delayToInit: const Duration(seconds: 30),
        ),
      ).called(1);

      verify(
        () => faceRecognitionCheckFaceRepository.call(employeeId: tEmployeeId),
      ).called(1);

      verify(
        () => sharedPreferencesService.getFacialRecognitionAuthentication(
          companyId: tCompanyId,
        ),
      );

      verify(() => sessionService.getCompanyId());
      verify(() => sessionService.hasEmployee());

      verify(
        () => workIndicatorService.addWorkIndicator(
          workIndicatorType: WorkIndicatorType.syncFaceEmployeeUsecase,
        ),
      );

      verify(
        () => workIndicatorService.removeWorkIndicator(
          workIndicatorType: WorkIndicatorType.syncFaceEmployeeUsecase,
        ),
      );

      verifyNoMoreInteractions(sessionService);
      verifyNoMoreInteractions(faceRecognitionSdkAuthenticationService);
      verifyNoMoreInteractions(sharedPreferencesService);
    });

    test(
        'should return success if you dont have facial recognition authentication test',
        () async {
      when(
        () => sharedPreferencesService.getFacialRecognitionAuthentication(
          companyId: tCompanyId,
        ),
      ).thenAnswer((_) async => false);

      when(
        () => faceRecognitionRegisterCompanyRepository.call(
          companyId: tCompanyId,
        ),
      ).thenAnswer((_) async => true);

      SynchronizationResult synchronizationResult =
          await syncFaceEmployeeUsecase.call();
      expect(synchronizationResult.status, SynchronizationStatus.success);
      expect(
        synchronizationResult.message,
        SynchronizationMessage.syncClockingEventSyncFailure,
      );
    });
  });
}
