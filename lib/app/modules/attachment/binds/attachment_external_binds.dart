import 'package:flutter_modular/flutter_modular.dart';
import 'package:platform/platform.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';

import '../../../core/services/share_service/share_service.dart';
import '../external/datasources/delete_attachment_datasource_impl.dart';
import '../external/datasources/download_attachment_datasource_impl.dart';
import '../external/datasources/get_uploaded_attachments_datasource_impl.dart';
import '../external/drivers/get_native_permission_storage_driver_impl.dart';
import '../external/drivers/share_file_driver_impl.dart';
import '../external/drivers/share_string_driver_impl.dart';
import '../external/mappers/attachment_model_mapper.dart';
import '../infra/datasources/delete_attachment_datasource.dart';
import '../infra/datasources/download_attachment_datasource.dart';
import '../infra/datasources/get_uploaded_attachments_datasource.dart';
import '../infra/drivers/get_native_permission_storage_driver.dart';
import '../infra/drivers/share_file_driver.dart';
import '../infra/drivers/share_string_driver.dart';

class AttachmentExternalBinds {
  static List<Bind<Object>> binds = [
    // Services
    Bind.singleton<ShareService>(
      (i) {
        return ShareServiceImpl(
          sharePlatform: SharePlatform.instance,
        );
      },
      export: true,
    ),

    // Mappers
    Bind.lazySingleton(
      (i) {
        return AttachmentModelMapper();
      },
      export: true,
    ),

    // DataSources
    Bind.singleton<GetNativePermissionStorageDriver>(
      (i) {
        return GetNativePermissionStorageDriverImpl(
          localPlatform: const LocalPlatform(),
        );
      },
      export: true,
    ),

    Bind.singleton<DeleteAttachmentDatasource>(
      (i) {
        return DeleteAttachmentDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetUploadedAttachmentsDatasource>(
      (i) {
        return GetUploadedAttachmentsDatasourceImpl(
          restService: i.get(),
          attachmentModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<DownloadAttachmentDatasource>(
      (i) {
        return DownloadAttachmentDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<ShareFileDriver>(
      (i) {
        return ShareFileDriverImpl(
          shareService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<ShareStringDriver>(
      (i) {
        return ShareStringDriverImpl(
          shareService: i.get(),
        );
      },
      export: true,
    ),
  ];
}
