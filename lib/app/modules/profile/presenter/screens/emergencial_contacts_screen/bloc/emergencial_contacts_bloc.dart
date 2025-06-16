import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/failures/profile_failure.dart';
import '../../../../domain/usecases/send_deletion_emergencial_contact_usecase.dart';
import '../../../../domain/usecases/send_emergencial_contact_usecase.dart';
import '../../../../domain/usecases/send_update_emergencial_contact_usecase.dart';
import 'emergencial_contacts_event.dart';
import 'emergencial_contacts_state.dart';

class EmergencialContactsBloc extends Bloc<EmergencialContactsEvent, EmergencialContactsState> {
  final SendEmergencialContactUsecase _sendEmergencialContactUsecase;
  final SendDeletionEmergencialContactUsecase _sendDeletionEmergencialContactUsecase;
  final SendUpdateEmergencialContactUsecase _sendUpdateEmergencialContactUsecase;

  EmergencialContactsBloc({
    required SendEmergencialContactUsecase sendEmergencialContactUsecase,
    required SendUpdateEmergencialContactUsecase sendUpdateEmergencialContactUsecase,
    required SendDeletionEmergencialContactUsecase sendDeletionEmergencialContactUsecase,
  })  : _sendEmergencialContactUsecase = sendEmergencialContactUsecase,
        _sendUpdateEmergencialContactUsecase = sendUpdateEmergencialContactUsecase,
        _sendDeletionEmergencialContactUsecase = sendDeletionEmergencialContactUsecase,
        super(InitialEmergencialContactsState()) {
    on<SendEmergencialContactsEvent>(_sendEmergencialContactsEvent);
    on<SendUpdateEmergencialContactsEvent>(_sendUpdateEmergencialContactsEvent);
    on<SendDeletionEmergencialContactEvent>(_sendDeletionEmergencialContactsEvent);
  }
  Future<void> _sendEmergencialContactsEvent(
    SendEmergencialContactsEvent event,
    Emitter<EmergencialContactsState> emit,
  ) async {
    emit(LoadingEmergencialContactsState());

    final emergencialContactUsecaseResult = await _sendEmergencialContactUsecase.call(
      emergencialContactInputModel: event.emergencialContactInputModel,
    );

    emergencialContactUsecaseResult.fold(
      (left) {
        emit(
          ErrorEmergencialContactsState(
            emergencialContactResult: left is SendEmergencialContactDatasourceFailure ? left.message : null,
          ),
        );
      },
      (right) {
        emit(LoadedEmergencialContactsState());
        emit(InitialEmergencialContactsState());
      },
    );
  }

  Future<void> _sendUpdateEmergencialContactsEvent(
    SendUpdateEmergencialContactsEvent event,
    Emitter<EmergencialContactsState> emit,
  ) async {
    emit(LoadingEmergencialContactsState());

    final emergencialContactUsecaseResult = await _sendUpdateEmergencialContactUsecase.call(
      emergencialContactId: event.emergencialContactId,
      emergencialContactInputModel: event.emergencialContactInputModel,
    );

    emergencialContactUsecaseResult.fold(
      (left) {
        emit(
          ErrorEmergencialContactsState(
            emergencialContactResult: left is SendEmergencialContactDatasourceFailure ? left.message : null,
          ),
        );
      },
      (right) {
        emit(LoadedEmergencialContactsState());
        emit(InitialEmergencialContactsState());
      },
    );
  }

  Future<void> _sendDeletionEmergencialContactsEvent(
    SendDeletionEmergencialContactEvent event,
    Emitter<EmergencialContactsState> emit,
  ) async {
    emit(DeletingEmergencialContactsState());

    final emergencialDeletionContactUploadedUsecaseResult = await _sendDeletionEmergencialContactUsecase.call(
      idEmergencialContact: event.idEmergencialContact,
    );

    emergencialDeletionContactUploadedUsecaseResult.fold(
      (left) {
        emit(
          SendDeletionErrorEmergencialContactsState(
            emergencialContactResult: left is SendDeletionEmergencialContactDatasourceFailure ? left.message : null,
          ),
        );
      },
      (right) {
        emit(DeletionEmergencialContactsState());
        emit(InitialEmergencialContactsState());
      },
    );
  }
}
