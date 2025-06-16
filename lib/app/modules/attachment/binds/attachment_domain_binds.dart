import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/delete_attachment_usecase.dart';
import '../domain/usecases/download_attachment_usecase.dart';
import '../domain/usecases/get_native_permission_storage_usecase.dart';
import '../domain/usecases/get_uploaded_attachments_usecase.dart';
import '../domain/usecases/share_file_usecase.dart';
import '../domain/usecases/share_string_usecase.dart';

class AttachmentDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.singleton<GetNativePermissionStorageUsecase>(
      (i) {
        return GetNativePermissionStorageUsecaseImpl(
          getNativePermissionStorageRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<DeleteAttachmentUsecase>(
      (i) {
        return DeleteAttachmentUsecaseImpl(
          deleteAttachmentRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetUploadedAttachmentsUsecase>(
      (i) {
        return GetUploadedAttachmentsUsecaseImpl(
          getUploadedAttachmentstRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<ShareFileUsecase>(
      (i) {
        return ShareFileUsecaseImpl(
          shareFileRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<DownloadAttachmentUsecase>(
      (i) {
        return DownloadAttachmentUsecaseImpl(
          downloadAttachmentRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<ShareStringUsecase>(
      (i) {
        return ShareStringUsecaseImpl(
          shareStringRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
