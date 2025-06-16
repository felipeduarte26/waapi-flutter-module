import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/download_attachment_usecase.dart';
import '../../../domain/usecases/get_native_permission_storage_usecase.dart';
import '../../../domain/usecases/share_file_usecase.dart';
import '../../../domain/usecases/share_string_usecase.dart';
import 'attachment_event.dart';
import 'attachment_state.dart';

class AttachmentBloc extends Bloc<AttachmentEvent, AttachmentState> {
  final DownloadAttachmentUsecase _downloadAttachmentUsecase;
  final ShareFileUsecase _shareFileUsecase;
  final ShareStringUsecase _shareStringUsecase;
  final GetNativePermissionStorageUsecase _getNativePermissionStorageUsecase;

  AttachmentBloc({
    required DownloadAttachmentUsecase downloadAttachmentUsecase,
    required ShareFileUsecase shareFileUsecase,
    required ShareStringUsecase shareStringUsecase,
    required GetNativePermissionStorageUsecase getNativePermissionStorageUsecase,
  })  : _downloadAttachmentUsecase = downloadAttachmentUsecase,
        _shareFileUsecase = shareFileUsecase,
        _shareStringUsecase = shareStringUsecase,
        _getNativePermissionStorageUsecase = getNativePermissionStorageUsecase,
        super(
          InitialAttachmentState(),
        ) {
    on<DownloadAttachmentEvent>(_downloadAttachmentEvent);
    on<ShareAttachmentEvent>(_shareAttachmentEvent);
    on<ShareFileReceivedEvent>(_shareFileReceivedEvent);
    on<ShareStringEvent>(_shareStringEvent);
  }

  Future<void> _downloadAttachmentEvent(
    DownloadAttachmentEvent event,
    Emitter<AttachmentState> emit,
  ) async {
    emit(
      LoadingAttachmentState(),
    );

    final permissionStatus = await _getNativePermissionStorageUsecase.call();

    if (permissionStatus.isLeft) {
      emit(
        ErrorNativePermissionStorageState(),
      );

      emit(
        InitialAttachmentState(),
      );
      return;
    }

    final attachmentIsDownloaded = await _downloadAttachmentUsecase.call(
      urlAttachment: event.attachmentEntity.link,
    );

    attachmentIsDownloaded.fold(
      (left) {
        emit(
          ErrorAttachmentsState(
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        emit(
          LoadedAttachmentsState(
            fileBytes: right,
            fileName: event.attachmentEntity.name,
          ),
        );
      },
    );
  }

  Future<void> _shareAttachmentEvent(
    ShareAttachmentEvent event,
    Emitter<AttachmentState> emit,
  ) async {
    emit(
      LoadingAttachmentState(),
    );

    final attachmentIsDownloaded = await _shareFileUsecase.call(
      fileToShare: event.file,
    );

    attachmentIsDownloaded.fold(
      (left) {
        emit(
          ErrorAttachmentsState(
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        emit(
          ShareFileInitialState(),
        );
      },
    );
  }

  Future<void> _shareFileReceivedEvent(
    ShareFileReceivedEvent event,
    Emitter<AttachmentState> emit,
  ) async {
    emit(LoadingAttachmentState());

    final permissionStatus = await _getNativePermissionStorageUsecase.call();

    if (permissionStatus.isLeft) {
      emit(
        ErrorNativePermissionStorageState(),
      );
      return;
    }

    final shareFileUsecase = await _shareFileUsecase.call(
      fileToShare: event.fileToShare,
    );

    shareFileUsecase.fold(
      (left) {
        emit(ErrorShareDetailsReceivedState());
      },
      (right) {
        emit(ShareFileInitialState());
        return;
      },
    );
  }

  Future<void> _shareStringEvent(
    ShareStringEvent event,
    Emitter<AttachmentState> emit,
  ) async {
    emit(LoadingAttachmentState());

    final shareStringUsecase = await _shareStringUsecase.call(
      stringToShare: event.stringToShare,
    );

    shareStringUsecase.fold(
      (left) {
        emit(ErrorShareStringState());
      },
      (right) {
        emit(ShareStringInitialState());
        return;
      },
    );
  }
}
