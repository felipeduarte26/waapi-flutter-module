import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_need_attachment_edit_usecase.dart';
import 'need_attachment_edit_event.dart';
import 'need_attachment_edit_state.dart';

class NeedAttachmentEditBloc extends Bloc<NeedAttachmentEditEvent, NeedAttachmentEditState> {
  final GetNeedAttachmentEditUsecase _getNeedAttachmentEditUsecase;

  NeedAttachmentEditBloc({
    required GetNeedAttachmentEditUsecase getNeedAttachmentEditUsecase,
  })  : _getNeedAttachmentEditUsecase = getNeedAttachmentEditUsecase,
        super(InitialNeedAttachmentEditState()) {
    on<GetNeedAttachmentEditEvent>(_getNeedAttachmentEditEvent);
  }

  Future<void> _getNeedAttachmentEditEvent(
    GetNeedAttachmentEditEvent event,
    Emitter<NeedAttachmentEditState> emit,
  ) async {
    emit(LoadingNeedAttachmentEditState());

    final needAttachmentEdit = await _getNeedAttachmentEditUsecase.call(
      role: event.role,
    );

    needAttachmentEdit.fold(
      (left) {
        emit(
          ErrorNeedAttachmentEditState(),
        );
      },
      (right) {
        emit(
          LoadedNeedAttachmentEditState(
            needAttachmentEdit: right,
          ),
        );
      },
    );
  }
}
