import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/failures/corporate_mural_failure.dart';
import '../../../domain/usecases/get_next_15_days_birthday_employees_usecase.dart';
import 'birthday_employees_event.dart';
import 'birthday_employees_state.dart';

class BirthdayEmployeesBloc extends Bloc<BirthdayEmployeesEvent, BirthdayEmployeesState> {
  final GetNext15DaysBirthdayEmployeesUsecase _getNext15DaysBirthdayEmployeesUsecase;

  BirthdayEmployeesBloc({
    required GetNext15DaysBirthdayEmployeesUsecase getNext15DaysBirthdayEmployeesUsecase,
  })  : _getNext15DaysBirthdayEmployeesUsecase = getNext15DaysBirthdayEmployeesUsecase,
        super(const InitialBirthdayEmployeesState()) {
    on<GetNext15DaysBirthdayEmployeesEvent>(_getNext15DaysBirthdayEmployeesEvent);
    on<ReloadNext15DaysBirthdayEmployeesEvent>(_reloadNext15DaysBirthdayEmployeesEvent);
  }

  Future<void> _getNext15DaysBirthdayEmployeesEvent(
    GetNext15DaysBirthdayEmployeesEvent event,
    Emitter<BirthdayEmployeesState> emit,
  ) async {
    final bool hasFinishedLoading = state is LoadingBirthdayEmployeesState ||
        state is LoadingMoreBirthdayEmployeesState ||
        state is LastPageBirthdayEmployeesState;

    if (hasFinishedLoading) {
      return;
    }

    if (state.birthdayEmployees.isEmpty) {
      emit(state.loadingBirthdayEmployeesState());
    } else {
      emit(
        state.loadingMoreBirthdayEmployeesState(
          birthdayEmployees: state.birthdayEmployees,
        ),
      );
    }

    final receivedBirthdays = await _getNext15DaysBirthdayEmployeesUsecase.call(
      paginationRequirements: event.paginationRequirements,
      currentDate: event.currentDate,
      employeeId: event.employeeId,
    );

    receivedBirthdays.fold(
      (left) {
        if (left is CorporateMuralDatasourceFailure) {
          if (state.birthdayEmployees.isNotEmpty) {
            emit(
              state.errorLoadingMoreBirthdayEmployeesState(
                birthdayEmployees: state.birthdayEmployees,
              ),
            );
          } else {
            emit(
              state.errorBirthdayEmployeesState(),
            );
          }
        } else {
          if (state.birthdayEmployees.isEmpty) {
            emit(state.emptyBirthdayEmployeesState());
          } else {
            emit(
              state.lastPageBirthdayEmployeesState(
                birthdayEmployees: state.birthdayEmployees,
              ),
            );
          }
        }
      },
      (right) {
        emit(
          state.loadedBirthdayEmployeesState(
            birthdayEmployees: state.birthdayEmployees + right.employeesByBirthday,
          ),
        );
      },
    );
  }

  Future<void> _reloadNext15DaysBirthdayEmployeesEvent(
    ReloadNext15DaysBirthdayEmployeesEvent _,
    Emitter<BirthdayEmployeesState> emit,
  ) async {
    emit(ReloadBirthdayEmployeesState());
  }
}
