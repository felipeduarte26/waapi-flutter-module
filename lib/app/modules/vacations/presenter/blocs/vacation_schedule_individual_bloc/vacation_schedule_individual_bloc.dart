import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/failures/vacations_failure.dart';
import '../../../domain/usecases/get_vacation_schedule_individual_usecase.dart';

part 'vacation_schedule_individual_event.dart';
part 'vacation_schedule_individual_state.dart';

class VacationScheduleIndividualBloc extends Bloc<VacationScheduleIndividualEvent, VacationScheduleIndividualState> {
  final GetVacationScheduleIndividualUsecase _getVacationScheduleIndividualUsecase;

  VacationScheduleIndividualBloc({
    required GetVacationScheduleIndividualUsecase getVacationScheduleIndividualUsecase,
  })  : _getVacationScheduleIndividualUsecase = getVacationScheduleIndividualUsecase,
        super(InitialVacationScheduleIndividualState()) {
    on<GetVacationScheduleIndividualEvent>(_getVacationScheduleIndividualEvent);
  }

  Future<bool> _getVacationScheduleIndividualEvent(
    GetVacationScheduleIndividualEvent event,
    Emitter<VacationScheduleIndividualState> emit,
  ) async {
    emit(LoadingVacationScheduleIndividualState());

    final vacationScheduleIndividualUsecaseResult = await _getVacationScheduleIndividualUsecase.call(
      vacationId: event.idVacation,
      employeeId: event.employeeId,
    );

    vacationScheduleIndividualUsecaseResult.fold(
      (left) {
        emit(
          ErrorVacationScheduleIndividualState(
            vacationScheduleIndividualResult: left is VacationRequestFailure ? left.messagesError : null,
          ),
        );
      },
      (right) {
        emit(
          LoadedVacationScheduleIndividualState(
            isVacationScheduleUpdating: right,
          ),
        );
      },
    );

    return true;
  }
}
