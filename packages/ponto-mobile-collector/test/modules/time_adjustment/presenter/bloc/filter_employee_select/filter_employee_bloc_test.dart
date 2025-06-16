import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/employee_item_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/pagination_employee_item_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_employees_to_completed_appointments_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/filter_employee_select/filter_employee_select_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/filter_employee_select/filter_employee_select_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/filter_employee_select/filter_employee_select_state.dart';

class MockGetCompletedAppointmentsUsecase extends Mock
    implements GetEmployeesToCompletedAppointmentsUsecase {}

class FakeEmployeeItemEntity extends Fake implements EmployeeItemEntity {}

void main() {
  late FilterEmployeeSelectBloc filterEmployeeSelectBloc;
  late GetEmployeesToCompletedAppointmentsUsecase
      getCompletedAppointmentsUsecase;

  PaginationEmployeeItemEntity paginationEmployeeItemEntity =
      PaginationEmployeeItemEntity(
    employees: [FakeEmployeeItemEntity()],
    pageNumber: 0,
    pageSize: 10,
    totalPage: 1,
  );

  setUp(() {
    getCompletedAppointmentsUsecase = MockGetCompletedAppointmentsUsecase();
    filterEmployeeSelectBloc = FilterEmployeeSelectBloc(
      getCompletedAppointmentsUsecase: getCompletedAppointmentsUsecase,
    );
    filterEmployeeSelectBloc.username = 'username';

    when(
      () => getCompletedAppointmentsUsecase.call(
        nameEmployee: any(named: 'nameEmployee'),
        username: any(named: 'username'),
      ),
    ).thenAnswer((_) async => paginationEmployeeItemEntity);
  });

  group('FilterEmployeeInitEvent Test', () {
    blocTest(
      'Test TimeAdjustmentSelectEmployeeSearch',
      build: () => filterEmployeeSelectBloc,
      act: (bloc) => bloc.add(FilterEmployeeInitEvent()),
      expect: () => [
        isA<FilterEmployeeSearchInProgress>(),
        isA<FilterReadyContent>(),
      ],
      verify: (_) {
        verify(
          () => getCompletedAppointmentsUsecase.call(
            nameEmployee: any(named: 'nameEmployee'),
            username: any(named: 'username'),
          ),
        ).called(1);
      },
    );

    blocTest(
      'Test FilterEmployeeSearchEvent',
      build: () => filterEmployeeSelectBloc,
      act: (bloc) => bloc.add(FilterEmployeeSearchEvent(page: 0)),
      expect: () => [
        isA<FilterEmployeeSearchInProgress>(),
        isA<FilterReadyContent>(),
      ],
      verify: (_) {
        verify(
          () => getCompletedAppointmentsUsecase.call(
            nameEmployee: any(named: 'nameEmployee'),
            username: any(named: 'username'),
          ),
        ).called(1);
      },
    );

    blocTest(
      'Test FilterEmployeeLoadMoreEvent',
      setUp: () {
        when(
          () => getCompletedAppointmentsUsecase.call(
            nameEmployee: any(named: 'nameEmployee'),
            username: any(named: 'username'),
            pageNumber: any(named: 'pageNumber'),
          ),
        ).thenAnswer((_) async => paginationEmployeeItemEntity);
      },
      build: () => filterEmployeeSelectBloc,
      act: (bloc) => bloc.add(FilterEmployeeLoadMoreEvent()),
      expect: () => [
        isA<FilterEmployeeSearchLoadMoreInProgress>(),
        isA<FilterReadyContent>(),
      ],
      verify: (_) {
        verify(
          () => getCompletedAppointmentsUsecase.call(
            nameEmployee: any(named: 'nameEmployee'),
            username: any(named: 'username'),
          ),
        ).called(1);
      },
    );

    blocTest(
      'Test FilterEmployeeSelectEmployeeEvent',
      build: () => filterEmployeeSelectBloc,
      act: (bloc) =>
          bloc.add(FilterEmployeeSelectEmployeeEvent(employeeId: 'employeeId')),
      expect: () => [
        isA<FilterEmployeeSelected>(),
      ],
      verify: (_) {
        expect(
          filterEmployeeSelectBloc.employeesSelected.contains('employeeId'),
          true,
        );
      },
    );

    blocTest(
      'Test FilterEmployeeClearSelectionEvent',
      build: () => filterEmployeeSelectBloc,
      act: (bloc) => bloc.add(FilterEmployeeClearSelectionEvent()),
      expect: () => [
        isA<FilterReadyContent>(),
      ],
      verify: (_) {
        expect(
          filterEmployeeSelectBloc.employees.length,
          0,
        );
      },
    );

    blocTest(
      'Test FilterEmployeeClearInputEvent',
      build: () => filterEmployeeSelectBloc,
      act: (bloc) => bloc.add(FilterEmployeeClearInputEvent()),
      expect: () => [isA<FilterReadyContent>()],
      verify: (_) {
        expect(
          filterEmployeeSelectBloc.getNameSearch(),
          null,
        );
      },
    );
  });
}
