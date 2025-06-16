import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/company_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/register_clocking_event_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/import_clocking_event_dto_mock.dart';

class EmployeeDTOFake extends Fake implements EmployeeDto {
  @override
  CompanyDto company;

  EmployeeDTOFake(this.company);

  @override
  EmployeeDto copyWith({
    String? id,
    ClockingEventRegisterType? employeeRegisterType,
  }) {
    return EmployeeDto(
      id: 'id',
      name: 'name',
      employeeType: 'employeeType',
      company: company,
      cpfNumber: 'cpf',
    );
  }
}

class CompanyDTOFake extends Fake implements CompanyDto {
  @override
  String? id = 'id';
}

class MockRegisterClockingEventService extends Mock
    implements IRegisterClockingEventService {}

class FakeImportClockingEventDto extends Fake
    implements clock.ImportClockingEventDto {}

void main() {
  late IRegisterClockingEventService registerClockingEventService;
  late EmployeeDto employeeDto;
  late CompanyDto companyDto;

  setUpAll(
    () {
      registerClockingEventService = MockRegisterClockingEventService();
      companyDto = CompanyDTOFake();
      employeeDto = EmployeeDTOFake(companyDto);
    },
  );

  group(
    'RegisterClockingEventUsecase',
    () {
      test(
        'call test.',
        () async {
          StateLocationEntity locationModel = StateLocationEntity(
            hasPermission: true,
            isMock: true,
            isServiceEnabled: true,
            success: true,
          );

          IRegisterClockingEventUsecase registerClockingEventUsecase =
              RegisterClockingEventUsecase(
            registerClockingEventService: registerClockingEventService,
          );

          DateTime dateTimeThatClockingEventProcessStarted = DateTime.now();

          ClockingEventRegisterEntity clockingEventRegisterEntity =
              ClockingEventRegisterEntity(
            clockingEventRegisterType: ClockingEventRegisterTypeSession(),
            dateTime: dateTimeThatClockingEventProcessStarted,
            employeeDto: employeeDto,
            location: locationModel,
            successFacialRecognition: false,
          );

          when(
            () => registerClockingEventService.register(
              clockingEventRegisterEntity: clockingEventRegisterEntity,
            ),
          ).thenAnswer(
            (invocation) => Future.value(importClockingEventDtoMock),
          );

          ClockingEventDto clockingEventDtoResult =
              await registerClockingEventUsecase.call(
            clockingEventRegisterEntity: clockingEventRegisterEntity,
          );

          expect(clockingEventDtoResult.appVersion, importClockingEventDtoMock.appVersion);
          expect(clockingEventDtoResult.appointmentImage, importClockingEventDtoMock.appointmentImage);
          expect(clockingEventDtoResult.clockingEventId, importClockingEventDtoMock.clockingEventId);

          verify(
            () => registerClockingEventService.register(
              clockingEventRegisterEntity: clockingEventRegisterEntity,
            ),
          ).called(1);

          verifyNoMoreInteractions(registerClockingEventService);
        },
      );
    },
  );
}
