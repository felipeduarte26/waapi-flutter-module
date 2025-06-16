import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/failures/vacations_failure.dart';
import '../../../domain/input_models/send_vacation_request_input_model.dart';
import '../../../domain/input_models/send_vacation_request_update_input_model.dart';
import '../../../domain/usecases/cancel_vacation_request_usecase.dart';
import '../../../domain/usecases/send_vacation_request_update_usecase.dart';
import '../../../domain/usecases/send_vacation_request_usecase.dart';

part 'vacation_request_event.dart';
part 'vacation_request_state.dart';

class VacationRequestBloc extends Bloc<VacationRequestEvent, VacationRequestState> {
  final SendVacationRequestUsecase _sendVacationRequestUsecase;
  final SendVacationRequestUpdateUseCase _sendVacationRequestUpdateUseCase;
  final CancelVacationRequestUsecase _cancelVacationRequestUsecase;

  VacationRequestBloc({
    required SendVacationRequestUsecase sendVacationRequestUsecase,
    required SendVacationRequestUpdateUseCase sendVacationRequestUpdateUseCase,
    required CancelVacationRequestUsecase cancelVacationRequestUsecase,
  })  : _sendVacationRequestUsecase = sendVacationRequestUsecase,
        _sendVacationRequestUpdateUseCase = sendVacationRequestUpdateUseCase,
        _cancelVacationRequestUsecase = cancelVacationRequestUsecase,
        super(InitialVacationRequestState()) {
    on<SendVacationRequestEvent>(_sendVacationRequestEvent);
    on<SendVacationRequestUpdateEvent>(_sendVacationRequestUpdateEvent);
    on<CancelVacationRequestEvent>(_cancelVacationRequestEvent);
  }

  Future<void> _sendVacationRequestEvent(
    SendVacationRequestEvent event,
    Emitter<VacationRequestState> emit,
  ) async {
    emit(LoadingVacationRequestState());

    final vacationRequestUsecaseResult = await _sendVacationRequestUsecase.call(
      sendVacationRequestInputModel: event.sendVacationRequestInputModel,
    );

    vacationRequestUsecaseResult.fold(
      (left) {
        emit(
          ErrorVacationRequestState(
            vacationRequestResult: left is VacationRequestFailure ? left.messagesError : null,
          ),
        );
      },
      (right) {
        emit(LoadedVacationRequestState());
      },
    );
  }

  Future<void> _sendVacationRequestUpdateEvent(
    SendVacationRequestUpdateEvent event,
    Emitter<VacationRequestState> emit,
  ) async {
    emit(LoadingVacationRequestState());

    final vacationRequestUpdateUsecaseResult = await _sendVacationRequestUpdateUseCase.call(
      sendVacationRequestUpdateInputModel: event.sendVacationRequestUpdateInputModel,
    );

    vacationRequestUpdateUsecaseResult.fold(
      (left) {
        emit(
          ErrorVacationRequestState(
            vacationRequestResult: left is VacationRequestFailure ? left.messagesError : null,
          ),
        );
      },
      (right) {
        emit(LoadedVacationRequestState());
      },
    );
  }

  Future<void> _cancelVacationRequestEvent(
    CancelVacationRequestEvent event,
    Emitter<VacationRequestState> emit,
  ) async {
    emit(LoadingVacationRequestState());

    final vacationRequestUsecaseResult = await _cancelVacationRequestUsecase.call(
      idVacation: event.idVacation,
      isApproved: event.isApproved,
      employeeId: event.employeeId,
    );

    vacationRequestUsecaseResult.fold(
      (left) {
        emit(
          ErrorVacationRequestState(
            vacationRequestResult: left is CancelVacationRequestFailure ? left.messagesError : null,
          ),
        );
      },
      (right) {
        emit(CanceledVacationRequestState());
      },
    );
  }
}
