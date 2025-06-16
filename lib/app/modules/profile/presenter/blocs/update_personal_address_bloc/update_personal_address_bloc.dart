import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/update_personal_address_usecase.dart';
import 'update_personal_address_event.dart';
import 'update_personal_address_state.dart';

class UpdatePersonalAddressBloc extends Bloc<UpdatePersonalAddressEvent, UpdatePersonalAddressState> {
  final UpdatePersonalAddressUsecase _updatePersonalAddressUsecase;

  UpdatePersonalAddressBloc({
    required UpdatePersonalAddressUsecase updatePersonalAddressUsecase,
  })  : _updatePersonalAddressUsecase = updatePersonalAddressUsecase,
        super(InitialUpdatePersonalAddressState()) {
    on<SendUpdatePersonalAddressEvent>(_sendUpdatePersonalAddressEvent);
  }

  Future<void> _sendUpdatePersonalAddressEvent(
    SendUpdatePersonalAddressEvent event,
    Emitter<UpdatePersonalAddressState> emit,
  ) async {
    emit(LoadingUpdatePersonalAddressState());

    final updatePersonalAddressResult = await _updatePersonalAddressUsecase.call(
      editPersonalAddressInputModel: event.editPersonalAddressInputModel,
    );

    updatePersonalAddressResult.fold(
      (left) {
        emit(
          ErrorUpdatePersonalAddressState(
            errorMessage: left.message,
          ),
        );
        emit(InitialUpdatePersonalAddressState());
      },
      (right) {
        emit(SentUpdatePersonalAddressState());
      },
    );
  }
}
