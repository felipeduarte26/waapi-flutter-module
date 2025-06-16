import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/search_employees_usecase.dart';
import 'search_employee_event.dart';
import 'search_employee_state.dart';

class SearchEmployeeBloc extends Bloc<SearchEmployeeEvent, SearchEmployeeState> {
  final SearchEmployeesUsecase _searchEmployeesUsecase;

  SearchEmployeeBloc({
    required SearchEmployeesUsecase searchEmployeesUsecase,
  })  : _searchEmployeesUsecase = searchEmployeesUsecase,
        super(const InitialSearchEmployeeState()) {
    on<SearchEmployeeToWriteFeedbackEvent>(
      _searchEmployee,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );

    on<SelectEmployeeFromEntityToWriteFeedbackEvent>(_selectEmployeeFromEntity);
    on<UnselectEmployeeFeedbackEvent>(_unselectEmployeeFeedbackEvent);
    on<ClearSearchEmployeeFeedbackEvent>(_clearSearchEmployeeFeedbackEvent);
  }

  Future<void> _clearSearchEmployeeFeedbackEvent(
    ClearSearchEmployeeFeedbackEvent _,
    Emitter<SearchEmployeeState> emit,
  ) async {
    emit(
      state.initialSearchEmployeeState(),
    );
  }

  Future<void> _unselectEmployeeFeedbackEvent(
    UnselectEmployeeFeedbackEvent _,
    Emitter<SearchEmployeeState> emit,
  ) async {
    emit(const InitialSearchEmployeeState());
  }

  Future<void> _searchEmployee(
    SearchEmployeeToWriteFeedbackEvent event,
    Emitter<SearchEmployeeState> emit,
  ) async {
    final bool isInvalidName = event.search.trim().length < 3;

    if (isInvalidName) {
      emit(state.initialSearchEmployeeState());
      return;
    }

    emit(state.loadingSearchEmployeeState());

    final employeeList = await _searchEmployeesUsecase.call(
      search: event.search,
    );

    employeeList.fold(
      (left) {
        emit(
          state.errorSearchEmployeeState(
            message: left.message,
            search: event.search,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateSearchEmployeesState());
        } else {
          emit(
            state.loadedSearchEmployeeState(
              employeeList: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectEmployeeFromEntity(
    SelectEmployeeFromEntityToWriteFeedbackEvent event,
    Emitter<SearchEmployeeState> emit,
  ) async {
    emit(
      state.loadedSelectEmployeeState(
        employeeEntity: event.employeeEntity,
      ),
    );
  }

  EventTransformer<SearchEmployeeToWriteFeedbackEvent> debounce<GetCompetencesEvent>(Duration duration) {
    return (events, mapper) {
      return events
          .debounceTime(
            duration,
          )
          .flatMap(
            mapper,
          );
    };
  }
}
