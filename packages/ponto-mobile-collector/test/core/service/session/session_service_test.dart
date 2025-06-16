import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/company_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/configuration_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../mocks/activation_dto_mock.dart';
import '../../../mocks/clock_company_dto_mock.dart';
import '../../../mocks/configuration_dto_mock.dart';
import '../../../mocks/employee_dto_mock.dart';
import '../../../mocks/login_employee_dto_mock.dart';
import '../../../mocks/token_mock.dart';

class MockEnvironmentService extends Mock implements IEnvironmentService {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class FakeLoginConfigurationDTO extends Fake
    implements ConfigurationDto {}

class FakeEmployeeDto extends Fake implements EmployeeDto {
  @override
  String? faceRegistered;
  @override
  String id;
  @override
  CompanyDto company;

  FakeEmployeeDto(this.id, this.company);
}

class FakeCompanyDto extends Fake implements CompanyDto {
  @override
  String id;

  FakeCompanyDto(this.id);
}

void main() {
  late ISessionService service;
  late ISharedPreferencesService sharedPreferencesService;

  setUp(() {
    registerFallbackValue(tokenMock);
    sharedPreferencesService = MockSharedPreferencesService();

    when(
      () => sharedPreferencesService.setSessionEmployeeId(
        employeeId: loginEmployeeDtoMock.id,
      ),
    ).thenAnswer((_) async => {});

    when(
      () => sharedPreferencesService.setFacialRecognitionAuthentication(
        companyId: any(named: 'companyId'),
        value: false,
      ),
    ).thenAnswer((_) async => {});

    service = SessionService.build(
      sharedPreferencesService: sharedPreferencesService,
    );
  });

  group('SessionService', () {
    test('Session Service with params test', () async {
      service.setLogedUser(
        configurationDto: configurationDTOMock,
        activationDto: activationDtoMock,
        employeeDto: employeeMockDto,
        username: tokenMock.username,
      );

      expect(service.getConfiguration().id, configurationDTOMock.id);
      expect(service.getConfiguration().allowChangeTime, configurationDTOMock.allowChangeTime);
      expect(service.getConfiguration().allowDrivingTime, configurationDTOMock.allowDrivingTime);
      expect(service.getConfiguration().faceRecognition, configurationDTOMock.faceRecognition);
      expect(service.getConfiguration().faceRecognitionSingle, configurationDTOMock.faceRecognitionSingle);
      expect(service.getConfiguration().allowGpoOnApp, configurationDTOMock.allowGpoOnApp);

      expect(service.getEmployee().id, employeeMockDto.id);
      expect(service.getEmployeeId(), employeeMockDto.id);
      expect(service.getExecutionMode(), ExecutionModeEnum.individual);
      expect(
        service.checkDeviceStatus(),
        DeviceAuthorizationStatusEnum.authorized,
      );
      expect(service.getTimeZoneOffset()!.inHours, -3);
      expect(service.hasEmployee(), true);
      expect(service.getCompanyId(), clockCompanyDtoMock.id);
    });

    test('Call clean session success test', () async {
      service.setLogedUser(
        configurationDto: configurationDTOMock,
        employeeDto: employeeMockDto,
        activationDto: activationDtoMock,
        username: tokenMock.username,
      );

      when(
        () => sharedPreferencesService.setSessionEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => {});

      await service.clean();

      verify(
        () => sharedPreferencesService.setSessionEmployeeId(
          employeeId: any(named: 'employeeId'),
        ),
      ).called(2);

      verify(
        () => sharedPreferencesService.setFacialRecognitionAuthentication(
          companyId: any(named: 'companyId'),
          value: false,
        ),
      ).called(1);

      verifyNoMoreInteractions(sharedPreferencesService);
    });

    test('call set setFaceRegistered', () {
      var faceRegisteredId = '79d3e21908514f7d914e1e7ae44607e4';
      var employeeId = '79d3e219-0851-4f7d-914e-1e7ae44607e4';
      var companyId = '97d8c5a1-4c83-4252-b74c-7ede2ab2ce6c';
      when(
        () => sharedPreferencesService.setSessionEmployeeId(
          employeeId: employeeId,
        ),
      ).thenAnswer((_) async => {});

      service.setLogedUser(
        configurationDto: FakeLoginConfigurationDTO(),
        employeeDto: FakeEmployeeDto(
          employeeId,
          FakeCompanyDto(companyId),
        ),
        username: tokenMock.username,
      );
      service.setFaceRegistered(id: faceRegisteredId);
      var employee = service.getEmployee();
      expect(faceRegisteredId, employee.faceRegistered);
    });
  });
}
