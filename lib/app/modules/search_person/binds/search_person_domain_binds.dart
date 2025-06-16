import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/search_person_by_term_usecase.dart';

class SearchPersonDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.singleton<SearchPersonByTermUsecase>((i) {
      return SearchPersonByTermUsecaseImpl(
        searchPersonByTermRepository: i.get(),
      );
    }),
  ];
}
