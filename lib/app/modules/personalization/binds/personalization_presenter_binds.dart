import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/bloc/personalization_bloc/personalization_bloc.dart';
import '../presenter/bloc/personalization_mobile_bloc/personalization_mobile_bloc.dart';

class PersonalizationPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.lazySingleton<PersonalizationBloc>(
      (i) {
        return PersonalizationBloc(
          getPersonalizationUsecase: i.get(),
        );
      },
      export: true,
    ),
     Bind.lazySingleton<PersonalizationMobileBloc>(
      (i) {
        return PersonalizationMobileBloc(
          getPersonalizationMobileUsecase: i.get(),
          cleanPersonalizationMobileDriverUsecase: i.get(),
        );
      },
      export: true,
    ),
  ];
}
