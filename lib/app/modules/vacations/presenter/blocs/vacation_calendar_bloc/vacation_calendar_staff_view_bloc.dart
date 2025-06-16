import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_vacation_calendar_staff_view_usercase.dart';
import 'vacation_calendar_staff_view_event.dart';
import 'vacation_calendar_staff_view_state.dart';

class VacationCalendarStaffViewBloc extends Bloc<VacationCalendarStaffViewEvent, VacationCalendarStaffViewState> {
  final GetVacationCalendarStaffViewUsercase _getVacationEmployeeCalendarViewUsercase;

  VacationCalendarStaffViewBloc({
    required GetVacationCalendarStaffViewUsercase getVacationEmployeeCalendarViewUsercase,
  })  : _getVacationEmployeeCalendarViewUsercase = getVacationEmployeeCalendarViewUsercase,
        super(InitialVacationCalendarState()) {
    on<GetVacationCalendarStaffViewEvent>(_getVacationCalendarEvent);
  }

  Future<void> _getVacationCalendarEvent(
    GetVacationCalendarStaffViewEvent event,
    Emitter<VacationCalendarStaffViewState> emit,
  ) async {
    emit(LoadingVacationCalendarState());

    final result = await _getVacationEmployeeCalendarViewUsercase.call(
      employeeId: event.filter.employeeId,
      startDate: event.startDate,
      endDate: event.endDate,
    );

    result.fold(
      (_) {
        emit(
          ErrorVacationsCalendarState(
            employeeId: event.filter.employeeId,
          ),
        );
      },
      (right) {
        if (right.vacationEmployeeCalendarViewEntity.isEmpty) {
          emit(EmptyVacationCalendarState());
          return;
        }
        emit(
          LoadedVacationCalendarStaffViewState(
            vacationCalendarStaffViewEntity: right,
          ),
        );
      },
    );
  }
}
