import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_vacations_usecase.dart';
import 'vacations_event.dart';
import 'vacations_state.dart';

class VacationsBloc extends Bloc<VacationsEvent, VacationsState> {
  final GetVacationsUsecase _getVacationsUsecase;

  VacationsBloc({
    required GetVacationsUsecase getVacationsUsecase,
  })  : _getVacationsUsecase = getVacationsUsecase,
        super(const InitialVacationsState()) {
    on<GetVacationsEvent>(_getVacationsEvent);
  }

  Future<void> _getVacationsEvent(
    GetVacationsEvent event,
    Emitter<VacationsState> emit,
  ) async {
    emit(state.loadingVacationsState());

    final vacations = await _getVacationsUsecase.call(
      employeeId: event.employeeId,
    );

    vacations.fold(
      (left) {
        if (state.vacations != null) {
          emit(state.errorUpdatingVacationsState());
          return;
        }
        emit(
          ErrorVacationsState(
            employeeId: event.employeeId,
          ),
        );
      },
      (right) {
        emit(
          state.loadedVacationsState(
            vacations: right,
            employeeId: event.employeeId,
          ),
        );
      },
    );
  }
}
