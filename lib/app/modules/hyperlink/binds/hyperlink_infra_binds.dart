import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_hyperlink_pdf_repository.dart';
import '../domain/repositories/get_hyperlinks_repository.dart';
import '../infra/adapters/hyperlink_entity_adapter.dart';
import '../infra/repositories/get_hyperlink_pdf_repository_impl.dart';
import '../infra/repositories/get_hyperlinks_repository_impl.dart';

class HyperlinkInfraBinds {
  static List<Bind<Object>> binds = [
    // Adapters
    Bind.factory(
      (i) {
        return HyperlinkEntityAdapter();
      },
    ),

    // Repositories
    Bind.factory<GetHyperlinksRepository>(
      (i) {
        return GetHyperlinksRepositoryImpl(
          getHyperlinksDatasource: i.get(),
          
          hyperlinkEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<GetHyperlinkPdfRepository>(
      (i) {
        return GetHyperlinkPdfRepositoryImpl(
          getHyperlinkPdfDatasource: i.get(),
          
        );
      },
    ),
  ];
}
