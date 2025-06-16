import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_active_contract_repository.dart';
import '../infra/adapters/active_contract_entity_adapter.dart';
import '../infra/repositores/get_active_contract_repository_impl.dart';

abstract class ActiveContractInfraBinds {
  static List<Bind<Object>> binds = [
    // Adapters
    Bind.lazySingleton(
      (i) {
        return ActiveContractEntityAdapter();
      },
      export: true,
    ),

    // Repositories
    Bind.lazySingleton<GetActiveContractRepository>(
      (i) {
        return GetActiveContractRepositoryImpl(
          getActiveContractDatasource: i.get(),
          activeContractEntityAdapter: i.get(),
          
        );
      },
      export: true,
    ),
  ];
}
