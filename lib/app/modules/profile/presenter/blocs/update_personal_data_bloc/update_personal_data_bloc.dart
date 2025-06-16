import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/update_personal_data_usecase.dart';
import 'update_personal_data_event.dart';
import 'update_personal_data_state.dart';

class UpdatePersonalDataBloc extends Bloc<UpdatePersonalDataEvent, UpdatePersonalDataState> {
  final UpdatePersonalDataUsecase _updatePersonalDataUsecase;

  UpdatePersonalDataBloc({
    required UpdatePersonalDataUsecase updatePersonalDataUsecase,
  })  : _updatePersonalDataUsecase = updatePersonalDataUsecase,
        super(InitialUpdatePersonalDataState()) {
    on<SendUpdatePersonalDataEvent>(_sendUpdatePersonalDataEvent);
  }

  Future<void> _sendUpdatePersonalDataEvent(
    SendUpdatePersonalDataEvent event,
    Emitter<UpdatePersonalDataState> emit,
  ) async {
    emit(LoadingUpdatePersonalDataState());

    final updatePersonalDataResult = await _updatePersonalDataUsecase.call(
      editPersonalDataInputModel: event.editPersonalDataInputModel,
    );

    updatePersonalDataResult.fold(
      (left) {
        emit(
          ErrorUpdatePersonalDataState(
            errorMessage: left.message,
          ),
        );
        emit(InitialUpdatePersonalDataState());
      },
      (right) {
        emit(SentUpdatePersonalDataState());
      },
    );
  }
}
