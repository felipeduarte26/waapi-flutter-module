import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/attachment_bloc/attachment_bloc.dart';
import '../presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';

class AttachmentPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.lazySingleton(
      (i) {
        return AttachmentBloc(
          downloadAttachmentUsecase: i.get(),
          getNativePermissionStorageUsecase: i.get(),
          shareFileUsecase: i.get(),
          shareStringUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return WaapiManagementPanelUploaderBloc(
          deleteAttachmentUsecase: i.get(),
          getUploadedAttachmentsUsecase: i.get(),
        );
      },
      export: true,
    ),
  ];
}
