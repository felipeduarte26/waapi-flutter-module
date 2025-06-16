import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_employee_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/employee_dto_mock.dart';

class MockSessionService extends Mock implements ISessionService {}

void main() {
  late ISessionService sessionService;

  setUp(() {
    sessionService = MockSessionService();
  });

  group(
    'GetEmployeeUsecase',
    () {
 test(
        'success call shold return employee test.',
        () async {
          when(() => sessionService.hasEmployee()).thenReturn(true);
          when(() => sessionService.getEmployee()).thenReturn(employeeMockDto);

          IGetEmployeeUsecase getEmployeeUsecase = GetEmployeeUsecase(
            sessionService: sessionService,
          );

          expect(
            getEmployeeUsecase.call()!,
           employeeMockDto,
          );

          verify(() => sessionService.hasEmployee()).called(1);
          verify(() => sessionService.getEmployee()).called(1);
        },
      );

      test(
        'success call shold return null test.',
        () async {
          when(() => sessionService.hasEmployee()).thenReturn(false);


          IGetEmployeeUsecase getEmployeeUsecase = GetEmployeeUsecase(
            sessionService: sessionService,
          );

          expect(getEmployeeUsecase.call(), null);
          verify(() => sessionService.hasEmployee()).called(1);
        },
      );
    },
  );
}
