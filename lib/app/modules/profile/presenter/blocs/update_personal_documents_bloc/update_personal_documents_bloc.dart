import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/update_personal_documents_usecase.dart';
import 'update_personal_documents_event.dart';
import 'update_personal_documents_state.dart';

class UpdatePersonalDocumentsBloc extends Bloc<UpdatePersonalDocumentsEvent, UpdatePersonalDocumentsState> {
  final UpdatePersonalDocumentsUsecase _updatePersonalDocumentsUsecase;

  UpdatePersonalDocumentsBloc({
    required UpdatePersonalDocumentsUsecase updatePersonalDocumentsUsecase,
  })  : _updatePersonalDocumentsUsecase = updatePersonalDocumentsUsecase,
        super(InitialUpdatePersonalDocumentsState()) {
    on<SendUpdatePersonalDocumentsEvent>(_sendUpdatePersonalDocumentsEvent);
  }

  Future<void> _sendUpdatePersonalDocumentsEvent(
    SendUpdatePersonalDocumentsEvent event,
    Emitter<UpdatePersonalDocumentsState> emit,
  ) async {
    emit(LoadingUpdatePersonalDocumentsState());

    final updatePersonalDocumentsResult = await _updatePersonalDocumentsUsecase.call(
      editPersonalDocumentsInputModel: event.editPersonalDocumentsInputModel,
    );

    updatePersonalDocumentsResult.fold(
      (left) {
        emit(
          ErrorUpdatePersonalDocumentsState(
            errorMessage: left.message,
          ),
        );
        emit(InitialUpdatePersonalDocumentsState());
      },
      (right) {
        emit(SentUpdatePersonalDocumentsState());
      },
    );
  }
}
