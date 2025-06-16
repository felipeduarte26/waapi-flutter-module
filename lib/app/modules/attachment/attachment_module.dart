import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/attachment_routes.dart';
import 'binds/attachment_domain_binds.dart';
import 'binds/attachment_external_binds.dart';
import 'binds/attachment_infra_binds.dart';
import 'binds/attachment_presenter_binds.dart';
import 'presenter/screens/view_pdf_screen.dart';

class AttachmentModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...AttachmentDomainBinds.binds,
      ...AttachmentInfraBinds.binds,
      ...AttachmentExternalBinds.binds,
      ...AttachmentPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        AttachmentRoutes.attachmentPdfScreenRoute,
        child: (_, args) {
          return ViewPdfScreen(
            filePath: args.data['filePath'],
            title: args.data['title'],
            pdfErrorAnalytics: args.data['pdfErrorAnalytics'],
            pdfSharedAnalytics: args.data['pdfSharedAnalytics'],
          );
        },
      ),
    ];
  }
}
