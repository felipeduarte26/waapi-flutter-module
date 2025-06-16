import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/input_models/dependent_dto_input_model.dart';
import '../../../domain/usecases/update_dependents_usecase.dart';

part 'edit_dependents_event.dart';
part 'edit_dependents_state.dart';

class EditDependentsBloc extends Bloc<EditDependentsEvent, EditDependentsState> {
  final UpdateDependentsUsecase _updateDependentsUsecase;

  EditDependentsBloc({
    required UpdateDependentsUsecase updateDependentsUsecase,
  })  : _updateDependentsUsecase = updateDependentsUsecase,
        super(InitialEditDependents()) {
    on<SendEditDependentsEvent>(_sendEditDependentsEvent);
  }
  Future<void> _sendEditDependentsEvent(
    SendEditDependentsEvent event,
    Emitter<EditDependentsState> emit,
  ) async {
    emit(LoadingEditDependents());

    final updateDependentResult = await _updateDependentsUsecase.call(
      sendDependentDtoInputModel: event.dependentDtoInputModel,
    );

    updateDependentResult.fold(
      (left) {
        emit(
          ErrorEditDependents(
            errorMessage: left.message,
          ),
        );
        emit(InitialEditDependents());
      },
      (right) {
        emit(SentEditDependents());
        emit(InitialEditDependents());
      },
    );
  }
}
