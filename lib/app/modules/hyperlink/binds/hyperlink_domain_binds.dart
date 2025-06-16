import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../domain/usecases/get_hyperlink_path_usecase.dart';
import '../domain/usecases/get_hyperlink_pdf_usecase.dart';
import '../domain/usecases/get_hyperlinks_usecase.dart';

class HyperlinkDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.factory<GetHyperlinksUsecase>(
      (i) {
        return GetHyperlinksUsecaseImpl(
          getHyperlinksRepository: i.get(),
        );
      },
    ),

    Bind.factory<GetHyperlinkPathUsecase>(
      (i) {
        return GetHyperlinkPathUsecaseImpl(
          getStoredTokenUsecase: GetStoredTokenUsecase(),
          getStoredUserUsecase: GetStoredUserUsecase(),
          getG5ConnectorUsecase: i.get(),
        );
      },
    ),

    Bind.factory<GetHyperlinkPdfUsecase>(
      (i) {
        return GetHyperlinkPdfUsecaseImpl(
          getHyperlinkPdfPathRepository: i.get(),
        );
      },
    ),
  ];
}
