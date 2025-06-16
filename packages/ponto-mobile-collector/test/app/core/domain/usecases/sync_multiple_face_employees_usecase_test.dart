import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/company.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/work_indicator_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_sync_face_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/work_indicator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_multiple_face_employees_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockFaceRecognitionSyncFaceRepository extends Mock
    implements FaceRecognitionSyncFaceRepository {}

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockLogService extends Mock implements LogService {}

class MockWorkIndicatorService extends Mock implements WorkIndicatorService {}

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

void main() {
  const String tEmployeeId = 'tEmployeeId';
  late ISyncMultipleFaceEmployeesUsecase syncMultipleFaceEmployeesUsecase;
  late FaceRecognitionSyncFaceRepository faceRecognitionSyncFaceRepository;
  late IEmployeeRepository employeeRepository;
  late LogService logService;
  late WorkIndicatorService workIndicatorService;
  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;

  setUp(() {
    faceRecognitionSyncFaceRepository = MockFaceRecognitionSyncFaceRepository();
    employeeRepository = MockEmployeeRepository();
    logService = MockLogService();
    workIndicatorService = MockWorkIndicatorService();
    faceRecognitionSdkAuthenticationService =
        MockFaceRecognitionSdkAuthenticationService();

    syncMultipleFaceEmployeesUsecase = SyncMultipleFaceEmployeesUsecase(
      faceRecognitionSyncFaceRepository: faceRecognitionSyncFaceRepository,
      employeeRepository: employeeRepository,
      logService: logService,
      workIndicatorService: workIndicatorService,
      faceRecognitionSdkAuthenticationService:
          faceRecognitionSdkAuthenticationService,
    );

    when(
      () =>
          faceRecognitionSdkAuthenticationService.getInitializationIsRunning(),
    ).thenReturn(false);

    when(
      () => workIndicatorService.addWorkIndicator(
        workIndicatorType: WorkIndicatorType.syncMultipleFaceEmployees,
      ),
    ).thenReturn(true);

    when(
      () => workIndicatorService.removeWorkIndicator(
        workIndicatorType: WorkIndicatorType.syncMultipleFaceEmployees,
      ),
    ).thenReturn(true);

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    when(
      () => faceRecognitionSyncFaceRepository.call(employeesId: [tEmployeeId]),
    ).thenAnswer((_) async => true);

    Company companyDto = const Company(
      name: 'name',
      timeZone: 'timeZone', id: '', cnpj: '',
    );

    Employee employeeDto = Employee(
      id: tEmployeeId,
      name: 'Test',
      employeeType: 'companyEmployee',
      company: companyDto,
      faceRegistered: tEmployeeId,
      cpf: '',
    );

    var list = [employeeDto];

    when(
      () => employeeRepository.findByFaceRegisteredNotEmpty(),
    ).thenAnswer((_) async => list);
  });

  group('SyncMultipleFaceEmployeesUsecase', () {
    test('should sync biometric face successfully test', () async {
      expect((await syncMultipleFaceEmployeesUsecase.call()), true);

      verify(
        () =>
            faceRecognitionSyncFaceRepository.call(employeesId: [tEmployeeId]),
      ).called(1);

      verifyNoMoreInteractions(faceRecognitionSyncFaceRepository);
    });

    test('should return true when employees is empty test', () async {
      when(
        () => employeeRepository.findByFaceRegisteredNotEmpty(),
      ).thenAnswer((_) async => []);

      expect((await syncMultipleFaceEmployeesUsecase.call()), true);

      verify(
        () => employeeRepository.findByFaceRegisteredNotEmpty(),
      );

      verifyNoMoreInteractions(employeeRepository);
    });
  });
}
