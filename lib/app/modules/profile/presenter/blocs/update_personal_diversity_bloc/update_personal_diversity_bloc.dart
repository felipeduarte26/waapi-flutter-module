import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/update_personal_diversity_usecase.dart';
import 'update_personal_diversity_event.dart';
import 'update_personal_diversity_state.dart';

class UpdatePersonalDiversityBloc extends Bloc<UpdatePersonalDiversityEvent, UpdatePersonalDiversityState> {
  final UpdatePersonalDiversityUsecase _updatePersonalDiversityUsecase;

  UpdatePersonalDiversityBloc({
    required UpdatePersonalDiversityUsecase updatePersonalDiversityUsecase,
  })  : _updatePersonalDiversityUsecase = updatePersonalDiversityUsecase,
        super(InitialUpdatePersonalDiversityState()) {
    on<SendUpdatePersonalDiversityEvent>(_sendUpdatePersonalDiversityEvent);
  }

  Future<void> _sendUpdatePersonalDiversityEvent(
    SendUpdatePersonalDiversityEvent event,
    Emitter<UpdatePersonalDiversityState> emit,
  ) async {
    emit(LoadingUpdatePersonalDiversityState());

    final updatePersonalDiversityResult = await _updatePersonalDiversityUsecase.call(
      editPersonalDiversityInputModel: event.editPersonalDiversityInputModel,
    );

    updatePersonalDiversityResult.fold(
      (left) {
        emit(
          ErrorUpdatePersonalDiversityState(
            errorMessage: left.message,
          ),
        );
        emit(InitialUpdatePersonalDiversityState());
      },
      (right) {
        emit(SentUpdatePersonalDiversityState());
      },
    );
  }
}
