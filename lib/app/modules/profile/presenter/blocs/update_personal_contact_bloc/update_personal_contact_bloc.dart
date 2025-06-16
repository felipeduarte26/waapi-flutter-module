import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/update_personal_contact_usecase.dart';
import 'update_personal_contact_event.dart';
import 'update_personal_contact_state.dart';

class UpdatePersonalContactBloc extends Bloc<UpdatePersonalContactEvent, UpdatePersonalContactState> {
  final UpdatePersonalContactUsecase _updatePersonalContactUsecase;

  UpdatePersonalContactBloc({
    required UpdatePersonalContactUsecase updatePersonalContactUsecase,
  })  : _updatePersonalContactUsecase = updatePersonalContactUsecase,
        super(InitialUpdatePersonalContactState()) {
    on<SendUpdatePersonalContactEvent>(_sendUpdatePersonalContactEvent);
  }

  Future<void> _sendUpdatePersonalContactEvent(
    SendUpdatePersonalContactEvent event,
    Emitter<UpdatePersonalContactState> emit,
  ) async {
    emit(LoadingUpdatePersonalContactState());

    final updatePersonalContactResult = await _updatePersonalContactUsecase.call(
      editPersonalContactInputModel: event.editPersonalContactInputModel,
    );

    updatePersonalContactResult.fold(
      (left) {
        emit(
          ErrorUpdatePersonalContactState(
            errorMessage: left.message,
          ),
        );
        emit(InitialUpdatePersonalContactState());
      },
      (right) {
        emit(SentUpdatePersonalContactState());
      },
    );
  }
}
