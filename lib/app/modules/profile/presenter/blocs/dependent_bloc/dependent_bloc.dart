import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_dependents_usecase.dart';
import 'dependent_event.dart';
import 'dependent_state.dart';

class DependentBloc extends Bloc<DependentEvent, DependentState> {
  final GetDependentsUsecase _getDependentsUsecase;

  DependentBloc({
    required GetDependentsUsecase getDependentsUsecase,
  })  : _getDependentsUsecase = getDependentsUsecase,
        super(const InitialDependentState()) {
    on<GetDependentsEvent>(_getDependentsEvent);
  }

  Future<void> _getDependentsEvent(
    GetDependentsEvent event,
    Emitter<DependentState> emit,
  ) async {
    emit(state.loadingDependentState());

    final dependents = await _getDependentsUsecase.call(
      employeeId: event.employeeId,
    );

    dependents.fold(
      (left) {
        emit(
          state.errorDependentState(),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateDependentState());
        } else {
          emit(
            state.loadedDependentState(
              dependents: right,
            ),
          );
        }
      },
    );
  }
}
