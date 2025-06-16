import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/search_person_by_term_datasource_impl.dart';
import '../external/mappers/person_model_mapper.dart';
import '../infra/datasources/search_person_by_term_datasource.dart';

class SearchPersonExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.singleton<SearchPersonByTermDatasource>((i) {
      return SearchPersonByTermDatasourceImpl(
        restService: i.get(),
        personModelMapper: i.get(),
      );
    }),

    // Mappers
    Bind.singleton((i) {
      return PersonModelMapper();
    }),
  ];
}
