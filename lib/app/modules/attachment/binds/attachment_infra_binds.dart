import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/delete_attachment_repository.dart';
import '../domain/repositories/download_attachment_repository.dart';
import '../domain/repositories/get_native_permission_storage_repository.dart';
import '../domain/repositories/get_uploaded_attachments_repository.dart';
import '../domain/repositories/share_file_repository.dart';
import '../domain/repositories/share_string_repository.dart';
import '../infra/adapters/attachment_entity_adapter.dart';
import '../infra/repositories/delete_attachment_repository_impl.dart';
import '../infra/repositories/download_attachment_repository_impl.dart';
import '../infra/repositories/get_native_permission_storage_repository_impl.dart';
import '../infra/repositories/get_uploaded_attachments_repository_impl.dart';
import '../infra/repositories/share_file_repository_impl.dart';
import '../infra/repositories/share_string_repository_impl.dart';

class AttachmentInfraBinds {
  static List<Bind<Object>> binds = [
    //Adapters
    Bind.singleton<AttachmentEntityAdapter>(
      (i) {
        return AttachmentEntityAdapter();
      },
      export: true,
    ),

    // Repositories
    Bind.singleton<DeleteAttachmentRepository>(
      (i) {
        return DeleteAttachmentRepositoryImpl(
          deleteAttachmentDatasource: i.get(),
          
        );
      },
      export: true,
    ),

    Bind.singleton<GetUploadedAttachmentsRepository>(
      (i) {
        return GetUploadedAttachmentsRepositoryImpl(
          attachmentEntityAdapter: i.get(),
          
          getUploadedAttachmentsDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetNativePermissionStorageRepository>(
      (i) {
        return GetNativePermissionStorageRepositoryImpl(
          getNativePermissionStorageDriver: i.get(),
          
        );
      },
      export: true,
    ),

    Bind.singleton<DownloadAttachmentRepository>(
      (i) {
        return DownloadAttachmentRepositoryImpl(
          downloadAttachmentDatasource: i.get(),
          
        );
      },
      export: true,
    ),

    Bind.singleton<ShareFileRepository>(
      (i) {
        return ShareFileRepositoryImpl(
          shareFileDatasource: i.get(),
          
        );
      },
      export: true,
    ),

    Bind.singleton<ShareStringRepository>(
      (i) {
        return ShareStringRepositoryImpl(
          shareStringDatasource: i.get(),
          
        );
      },
      export: true,
    ),
  ];
}
