import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_active_contract_usecase.dart';

abstract class ActiveContractDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.lazySingleton<GetActiveContractUsecase>(
      (i) {
        return GetActiveContractUsecaseImpl(
          getActiveContractRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
