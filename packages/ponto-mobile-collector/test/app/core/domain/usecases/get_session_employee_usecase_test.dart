import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/session/isession_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/shared_preferences/ishared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_session_employee_usecase.dart';

import '../../../../mocks/employee_dto_mock.dart';

class MockSessionService extends Mock implements ISessionService {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

void main() {
  late GetSessionEmployeeUsecase getSessionEmployeeUsecase;
  late ISessionService sessionService;

  setUp(() {
    sessionService = MockSessionService();

    when(
      () => sessionService.hasEmployee(),
    ).thenReturn(true);

    when(
      () => sessionService.getEmployee(),
    ).thenReturn(employeeMockDto);

    getSessionEmployeeUsecase = GetSessionEmployeeUsecaseImpl(
      sessionService: sessionService,
    );
  });

  group('GetSessionEmployeeUsecase', () {
    test('should return employee successfully test', () async {
      EmployeeDto? employeeDto = getSessionEmployeeUsecase.call();

      expect(employeeDto, employeeMockDto);

      verify(
        () => sessionService.hasEmployee(),
      ).called(1);

      verify(
        () => sessionService.getEmployee(),
      ).called(1);

      verifyNoMoreInteractions(sessionService);
    });

    test('should return null employee test', () async {
      when(
        () => sessionService.hasEmployee(),
      ).thenReturn(false);

      EmployeeDto? employeeDto = getSessionEmployeeUsecase.call();

      expect(employeeDto, null);

      verify(
        () => sessionService.hasEmployee(),
      ).called(1);

      verifyNoMoreInteractions(sessionService);
    });
  });
}
