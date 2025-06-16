import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/delete_attachment_usecase.dart';
import '../../../domain/usecases/get_uploaded_attachments_usecase.dart';
import 'waapi_management_panel_uploader_event.dart';
import 'waapi_management_panel_uploader_state.dart';

class WaapiManagementPanelUploaderBloc
    extends Bloc<WaapiManagementPanelUploaderEvent, WaapiManagementPanelUploaderState> {
  final DeleteAttachmentUsecase _deleteAttachmentUsecase;
  final GetUploadedAttachmentsUsecase _getUploadedAttachmentsUsecase;

  WaapiManagementPanelUploaderBloc({
    required DeleteAttachmentUsecase deleteAttachmentUsecase,
    required GetUploadedAttachmentsUsecase getUploadedAttachmentsUsecase,
  })  : _deleteAttachmentUsecase = deleteAttachmentUsecase,
        _getUploadedAttachmentsUsecase = getUploadedAttachmentsUsecase,
        super(const InitialPanelUploaderState(attachments: [])) {
    on<DeleteAttachmentPanelUploaderEvent>(_deleteAttachmentEvent);
    on<UploadAttachmentPanelUploaderEvent>(_uploadAttachmentEvent);
    on<HasAttachmentToUploadPanelUploaderEvent>(_hasAttachmentToUploadEvent);
  }

  Future<void> _deleteAttachmentEvent(
    DeleteAttachmentPanelUploaderEvent event,
    Emitter<WaapiManagementPanelUploaderState> emit,
  ) async {
    if (state is ErrorUploadPanelUploaderState) {
      final attachments = [...state.attachments];
      attachments.retainWhere((element) => element.id != event.idAttachment);
      emit(
        DeletedPanelUploaderState(
          attachments: attachments,
        ),
      );
      emit(
        state.initialPanelUploaderState(
          attachments: attachments,
        ),
      );
      return;
    }

    emit(
      state.deletingPanelUploaderState(
        attachments: state.attachments,
        attachmentName: event.nameAttachment,
      ),
    );

    final attachmentIsDeleted = await _deleteAttachmentUsecase.call(
      idAttachment: event.idAttachment,
    );

    attachmentIsDeleted.fold(
      (left) {
        emit(
          ErrorDeletePanelUploaderState(),
        );
        return;
      },
      (right) {
        final attachments = [...state.attachments];
        attachments.retainWhere((element) => element.id != event.idAttachment);
        emit(
          DeletedPanelUploaderState(
            attachments: attachments,
          ),
        );
        emit(
          state.initialPanelUploaderState(
            attachments: attachments,
          ),
        );
      },
    );
  }

  Future<void> _uploadAttachmentEvent(
    UploadAttachmentPanelUploaderEvent event,
    Emitter<WaapiManagementPanelUploaderState> emit,
  ) async {
    emit(
      state.uploadingPanelUploaderState(
        file: event.file,
        contentType: event.contentType,
        formData: event.formData,
        attachmentName: event.nameAttachment,
      ),
    );

    final attachmentIsUploaded = await _getUploadedAttachmentsUsecase.call(
      file: event.file,
      contentType: event.contentType,
      formData: event.formData,
    );

    attachmentIsUploaded.fold(
      (left) {
        emit(
          ErrorUploadPanelUploaderState(
            file: event.file,
            contentType: event.contentType,
            attachments: state.attachments,
          ),
        );
      },
      (right) {
        final attachments = state.attachments.toList();
        attachments.add(right);

        emit(
          state.initialPanelUploaderState(
            attachments: attachments,
          ),
        );
      },
    );
  }

  void _hasAttachmentToUploadEvent(
    HasAttachmentToUploadPanelUploaderEvent event,
    Emitter<WaapiManagementPanelUploaderState> emit,
  ) {
    if (state is InitialPanelUploaderState &&
        state.attachments.isEmpty &&
        event.attachments.isNotEmpty) {
      emit(state.initialPanelUploaderState(attachments: event.attachments));
    }
  }
}
