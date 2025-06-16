import 'package:flutter_modular/flutter_modular.dart';

import '../../g5/presenter/bloc/g5_connector_bloc/g5_connector_bloc.dart';

class G5PresenterBinds {
  static List<Bind<Object>> binds = [
    Bind.factory<G5ConnectorBloc>(
      (i) {
        return G5ConnectorBloc(
          getG5ConnectorUsecase: i.get(),
        );
      },
      export: true,
    ),
  ];
}
