import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/active_contract_bloc/active_contract_bloc.dart';

abstract class ActiveContractPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.lazySingleton(
      (i) {
        return ActiveContractBloc(
          getActiveContractUsecase: i.get(),
        );
      },
      export: true,
    ),
  ];
}
