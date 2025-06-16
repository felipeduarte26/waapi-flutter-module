import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/employee_item_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/pagination_employee_item_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_employees_to_completed_appointments_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_state.dart';

class MockGetCompletedAppointmentsUsecase extends Mock
    implements GetEmployeesToCompletedAppointmentsUsecase {}

class FakeEmployeeItemEntity extends Fake implements EmployeeItemEntity {}

void main() {
  late TimeAdjustmentSelectEmployeeBloc timeAdjustmentSelectEmployeeBloc;
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
    timeAdjustmentSelectEmployeeBloc = TimeAdjustmentSelectEmployeeBloc(
      getCompletedAppointmentsUsecase: getCompletedAppointmentsUsecase,
    );
    timeAdjustmentSelectEmployeeBloc.username = 'username';

    when(
      () => getCompletedAppointmentsUsecase.call(
        nameEmployee: any(named: 'nameEmployee'),
        username: any(named: 'username'),
      ),
    ).thenAnswer((_) async => paginationEmployeeItemEntity);
  });

  group('TimeAdjustmentSelectEmployeeBloc Test', () {
    blocTest(
      'Test TimeAdjustmentSelectEmployeeSearch',
      build: () => timeAdjustmentSelectEmployeeBloc,
      act: (bloc) => bloc.add(TimeAdjustmentSelectEmployeeSearch()),
      expect: () => [
        isA<MultipleEmployeeSearchInProgress>(),
        isA<MultipleReadyContent>(),
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
      'Test TimeAdjustmentSelectEmployeeLoadMore',
      setUp: () {
        when(
          () => getCompletedAppointmentsUsecase.call(
            nameEmployee: any(named: 'nameEmployee'),
            username: any(named: 'username'),
            pageNumber: any(named: 'pageNumber'),
          ),
        ).thenAnswer((_) async => paginationEmployeeItemEntity);
      },
      build: () => timeAdjustmentSelectEmployeeBloc,
      act: (bloc) => bloc.add(TimeAdjustmentSelectEmployeeLoadMore()),
      expect: () => [
        isA<MultipleEmployeeSearchLoadMoreInProgress>(),
        isA<MultipleReadyContent>(),
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
      'Test TimeAdjustmentSelectedEmployee',
      build: () => timeAdjustmentSelectEmployeeBloc,
      act: (bloc) =>
          bloc.add(TimeAdjustmentSelectedEmployee(employeeId: 'employeeId')),
      expect: () => [
        isA<MultipleEmployeeSelected>(),
      ],
      verify: (_) {
        expect(
          timeAdjustmentSelectEmployeeBloc.selectedEmployee,
          'employeeId',
        );
      },
    );

    blocTest(
      'Test TimeAdjustmentSelectEmployeeSearching',
      build: () => timeAdjustmentSelectEmployeeBloc,
      act: (bloc) => bloc.add(
        TimeAdjustmentSelectEmployeeSearching(
          employeeNameSearch: 'employeeNameSearch',
        ),
      ),
      expect: () => [],
      verify: (_) {
        expect(
          timeAdjustmentSelectEmployeeBloc.getNameSearch(),
          'employeeNameSearch',
        );
      },
    );

    blocTest(
      'Test TimeAdjustmentSelectEmployeeSearchClean',
      build: () => timeAdjustmentSelectEmployeeBloc,
      act: (bloc) => bloc.add(TimeAdjustmentSelectEmployeeSearchClean()),
      expect: () => [isA<MultipleReadyContent>()],
      verify: (_) {
        expect(
          timeAdjustmentSelectEmployeeBloc.getNameSearch(),
          null,
        );
      },
    );
  });
}
