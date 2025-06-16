import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/bloc/ia_assist_bloc/ia_assist_bloc.dart';

class IAAssistPresenterBinds {
  static List<Bind<Object>> binds = [
    Bind.factory<IAAssistBloc>(
      (i) {
        return IAAssistBloc(iaAssistUsecase: i.get());
      },
      export: true,
    ),
  ];
}
