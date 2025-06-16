import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/employee.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_register_face_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/session/isession_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/register_face_employee_usecase.dart';

import '../../../../mocks/status_face_employee_mock.dart';

class MockFaceRecognitionRegisterFaceRepository extends Mock
    implements FaceRecognitionRegisterFaceRepository {}

class MockSessionService extends Mock implements ISessionService {}

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class EmployeeFake extends Fake implements Employee {
  @override
  String id;

  EmployeeFake({required this.id});
}

void main() {
  const String tImageBase64 = 'imageBase64';
  const String tEmployeeId = 'tEmployeeId';
  const String tCompanyId = 'tCompanyId';
  late IRegisterFaceEmployeeUsecase registerFaceEmployeeUsecase;
  late FaceRecognitionRegisterFaceRepository
      faceRecognitionRegisterFaceRepository;
  late ISessionService sessionService;
  late IEmployeeRepository employeeRepository;

  setUp(() {
    faceRecognitionRegisterFaceRepository =
        MockFaceRecognitionRegisterFaceRepository();
    sessionService = MockSessionService();
    employeeRepository = MockEmployeeRepository();

    registerFaceEmployeeUsecase = RegisterFaceEmployeeUsecase(
      faceRecognitionRegisterFaceRepository:
          faceRecognitionRegisterFaceRepository,
      sessionService: sessionService,
      employeeRepository: employeeRepository,
    );

    when(
      () => sessionService.getCompanyId(),
    ).thenReturn(tCompanyId);
  });

  group('RegisterFaceEmployeeUsecase', () {
    test('should return face status successfully test', () async {
      String? employeeIdSelected;
      when(
        () => faceRecognitionRegisterFaceRepository.call(
          imageBase64: tImageBase64,
          employeeIdSelected: employeeIdSelected,
        ),
      ).thenAnswer((_) async => statusFaceEmployeeMock);

      when(
        () => employeeRepository.updateFaceRegisteredByEmployeeId(
          employeeId: tEmployeeId,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => sessionService.getEmployeeId(),
      ).thenReturn(tEmployeeId);

      var employeeFake = EmployeeFake(id: tEmployeeId);
      when(
        () => employeeRepository.findById(id: tEmployeeId),
      ).thenAnswer((_) async => employeeFake);

      var statusFaceEmployee = await registerFaceEmployeeUsecase.call(
        tImageBase64,
        employeeIdSelected,
      );
      expect(
        statusFaceEmployee,
        statusFaceEmployeeMock,
      );

      verify(
        () => faceRecognitionRegisterFaceRepository.call(
          imageBase64: tImageBase64,
          employeeIdSelected: employeeIdSelected,
        ),
      ).called(1);
    });
  });
}
