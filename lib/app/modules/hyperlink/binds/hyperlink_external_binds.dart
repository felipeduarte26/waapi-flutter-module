import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../external/datasources/get_hyperlink_pdf_path_datasource_impl.dart';
import '../external/datasources/get_hyperlinks_datasource_impl.dart';
import '../external/mappers/get_hyperlinks_model_mapper.dart';
import '../infra/datasources/get_hyperlink_pdf_path_datasource.dart';
import '../infra/datasources/get_hyperlinks_datasource.dart';

class HyperlinkExternalBinds {
  static List<Bind<Object>> binds = [
    // Mappers
    Bind.factory(
      (i) {
        return GetHyperlinksModelMapper(
          attachmentModelMapper: i.get(),
        );
      },
    ),

    // Datasources
    Bind.factory<GetHyperlinksDatasource>(
      (i) {
        return GetHyperlinksDatasourceImpl(
          restService: i.get(),
          getHyperlinksModelMapper: i.get(),
        );
      },
    ),

    Bind.factory<GetHyperlinkPdfPathDatasource>(
      (i) {
        return GetHyperlinkPdfPathDatasourceImpl(
          restService: i.get(),
          getStoredTokenUsecase: GetStoredTokenUsecase(),
          getStoredUserUsecase: GetStoredUserUsecase(),
        );
      },
    ),
  ];
}
