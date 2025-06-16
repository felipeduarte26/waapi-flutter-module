import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/moods_bloc/moods_bloc.dart';

class MoodsPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.singleton<MoodsBloc>(
      (i) {
        return MoodsBloc(
          getMoodsPulseLinkUsecase: i.get(),
        );
      },
      export: true,
    ),
  ];
}
