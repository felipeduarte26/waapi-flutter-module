import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_employee_manager_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_clocking_event_by_manager_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_employees_by_manager_usecase.dart';

//import '../../../../../../mocks/clock_company_dto_mock.dart';
import '../../../../../../mocks/clocking_event_dto_mock.dart';
import '../../../../../../mocks/employee_dto_mock.dart';
import '../../../../../../mocks/employee_entity_mock.dart';

class MockGetEmployeeManagerUsecase extends Mock
    implements GetEmployeeManagerUsecase {}

class MockGetEmployeesByManagerUsecase extends Mock
    implements GetEmployeesByManagerUsecase {}

void main() {
  late GetClockingEventByManagerUsecaseImpl usecase;
  late MockGetEmployeeManagerUsecase mockGetEmployeeManagerUsecase;
  late MockGetEmployeesByManagerUsecase mockGetEmployeesByManagerUsecase;

  setUp(() {
    mockGetEmployeeManagerUsecase = MockGetEmployeeManagerUsecase();
    mockGetEmployeesByManagerUsecase = MockGetEmployeesByManagerUsecase();
    usecase = GetClockingEventByManagerUsecaseImpl(
      getEmployeeManagerUsecase: mockGetEmployeeManagerUsecase,
      getEmployeesByManagerUsecase: mockGetEmployeesByManagerUsecase,
    );
  });

  group('GetClockingEventByManagerUsecaseImpl', () {
    test('should return filtered clocking events for the manager and employees',
        () async {
      // Arrange
      const username = 'manager1';
      final managerEmployee = employeeMockDto;
      final employeesListByManager = [
        employeeEntityMock,
        employeeEntityMock,
      ];
      final appointments = [
        clockingEventDtoMock,
        clockingEventDtoMock,
        clockingEventDtoMock,
      ];

      when(() => mockGetEmployeeManagerUsecase.call(
              username: any(named: 'username'),),)
          .thenAnswer((_) async => managerEmployee);
      when(() => mockGetEmployeesByManagerUsecase.call(
              username: any(named: 'username'),),)
          .thenAnswer((_) async => employeesListByManager);

      // Act
      final result =
          await usecase.call(appointments: appointments, username: username);

      // Assert
      expect(result.length, 3);
      expect(
        result,
        containsAll([
          appointments[0], // Manager's event
          appointments[1], // Employee 1's event
        ]),
      );
      verify(() => mockGetEmployeeManagerUsecase.call(username: username))
          .called(1);
      verify(() => mockGetEmployeesByManagerUsecase.call(username: username))
          .called(1);
    });

    test('should return empty list if no matching clocking events are found',
        () async {
      // Arrange
      const username = 'manager1';
      final employeesListByManager = [
        employeeEntityMock,
        employeeEntityMock,
      ];
      List<ClockingEventDto> appointments = [];

      when(() => mockGetEmployeeManagerUsecase.call(username: username))
          .thenAnswer((_) async => employeeMockDto);
      when(() => mockGetEmployeesByManagerUsecase.call(username: username))
          .thenAnswer((_) async => employeesListByManager);

      // Act
      final result =
          await usecase.call(appointments: appointments, username: username);

      // Assert
      expect(result, isEmpty);
      verify(() => mockGetEmployeeManagerUsecase.call(username: username))
          .called(1);
      verify(() => mockGetEmployeesByManagerUsecase.call(username: username))
          .called(1);
    });

    test('should handle null managerEmployee gracefully', () async {
      // Arrange
       const username = 'manager1';
      final employeesListByManager = [
        employeeEntityMock,
        employeeEntityMock,
      ];
      List<ClockingEventDto> appointments = [clockingEventDtoMock,clockingEventDtoMock2];

      when(() => mockGetEmployeeManagerUsecase.call(username: username))
          .thenAnswer((_) async => null);
      when(() => mockGetEmployeesByManagerUsecase.call(username: username))
          .thenAnswer((_) async => employeesListByManager);

      // Act
      final result =
          await usecase.call(appointments: appointments, username: username);

      // Assert
      expect(result.length, 1);
      expect(result, contains(appointments[0])); // Employee 1's event
      verify(() => mockGetEmployeeManagerUsecase.call(username: username)).called(1);
      verify(() => mockGetEmployeesByManagerUsecase.call(username: username))
          .called(1);
    });
  });
}
