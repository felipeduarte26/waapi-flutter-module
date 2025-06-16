import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_next_15_days_birthdays_company_usecase.dart';
import 'company_birthdays_event.dart';
import 'company_birthdays_state.dart';

class CompanyBirthdaysBloc extends Bloc<CompanyBirthdaysEvent, CompanyBirthdaysState> {
  final GetNext15DaysBirthdaysCompanyUsecase _getNext15DaysBirthdaysCompanyUsecase;

  CompanyBirthdaysBloc({
    required GetNext15DaysBirthdaysCompanyUsecase getNext15DaysBirthdaysCompanyUsecase,
  })  : _getNext15DaysBirthdaysCompanyUsecase = getNext15DaysBirthdaysCompanyUsecase,
        super(const InitialCompanyBirthdaysState()) {
    on<GetNext15DaysBirthdaysCompanyEvent>(_getNext15DaysBirthdaysCompanyEvent);
    on<ReloadNext15DaysBirthdaysCompanyEvent>(_reloadNext15DaysBirthdaysCompanyEvent);
  }

  Future<void> _getNext15DaysBirthdaysCompanyEvent(
    GetNext15DaysBirthdaysCompanyEvent event,
    Emitter<CompanyBirthdaysState> emit,
  ) async {
    final bool hasFinishedLoading = state is LoadingCompanyBirthdaysState ||
        state is LoadingMoreCompanyBirthdaysState ||
        state is LastPageCompanyBirthdaysState;

    if (hasFinishedLoading) {
      return;
    }

    if (state.employeesByYearHireEntityList.isEmpty) {
      emit(state.loadingCompanyBirthdaysState());
    } else {
      emit(
        state.loadingMoreCompanyBirthdaysState(
          employeesByYearHireEntityList: state.employeesByYearHireEntityList,
        ),
      );
    }

    final employeesByYearHireEntityList = await _getNext15DaysBirthdaysCompanyUsecase.call(
      paginationRequirements: event.paginationRequirements,
      currentDate: event.currentDate,
      employeeId: event.employeeId,
    );

    employeesByYearHireEntityList.fold(
      (left) {
        if (state.employeesByYearHireEntityList.isNotEmpty) {
          emit(
            state.errorLoadingMoreErrorCompanyBirthdaysState(
              employeesByYearHireEntityList: state.employeesByYearHireEntityList,
            ),
          );
        } else {
          emit(
            state.errorCompanyBirthdaysState(),
          );
        }
      },
      (right) {
        if (right.isEmpty) {
          if (state.employeesByYearHireEntityList.isEmpty) {
            emit(state.emptyCompanyBirthdaysState());
          } else {
            emit(
              state.lastPageCompanyBirthdaysState(
                employeesByYearHireEntityList: state.employeesByYearHireEntityList,
              ),
            );
          }
        } else {
          emit(
            state.loadedCompanyBirthdaysState(
              employeesByYearHireEntityList: state.employeesByYearHireEntityList + right,
            ),
          );
        }
      },
    );
  }

  Future<void> _reloadNext15DaysBirthdaysCompanyEvent(
    ReloadNext15DaysBirthdaysCompanyEvent _,
    Emitter<CompanyBirthdaysState> emit,
  ) async {
    emit(ReloadCompanyBirthdaysState());
  }
}
