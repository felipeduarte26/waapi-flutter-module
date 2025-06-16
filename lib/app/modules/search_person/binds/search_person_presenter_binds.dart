import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/search_person/search_person_bloc.dart';
import '../presenter/screens/search_person_screen/blocs/search_person_screen_bloc.dart';

class SearchPersonPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.singleton((i) {
      return SearchPersonBloc(
        searchPersonByTermUsecase: i.get(),
      );
    }),

    Bind.singleton((i) {
      return SearchPersonScreenBloc(
        searchPersonBloc: i.get(),
      );
    }),
  ];
}
