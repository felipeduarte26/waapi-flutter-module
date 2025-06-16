import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/search_person_by_term_repository.dart';
import '../infra/adapters/person_entity_adapter.dart';
import '../infra/repositories/search_person_by_term_repository_impl.dart';

class SearchPersonInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.singleton<SearchPersonByTermRepository>((i) {
      return SearchPersonByTermRepositoryImpl(
        
        personEntityAdapter: i.get(),
        searchPersonByTermDatasource: i.get(),
      );
    }),

    // Entity adapters
    Bind.singleton(
      (i) {
        return PersonEntityAdapter();
      },
      export: true,
    ),
  ];
}
