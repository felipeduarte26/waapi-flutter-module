import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/get_active_contract_datasource_impl.dart';
import '../external/mappers/active_contract_model_mapper.dart';
import '../infra/datasources/get_active_contract_datasource.dart';

abstract class ActiveContractExternalBinds {
  static List<Bind<Object>> binds = [
    // Mappers
    Bind.lazySingleton(
      (i) {
        return ActiveContractModelMapper();
      },
      export: true,
    ),

    // Datasources
    Bind.lazySingleton<GetActiveContractDatasource>(
      (i) {
        return GetActiveContractDatasourceImpl(
          restService: i.get(),
          activeContractModelMapper: i.get(),
        );
      },
      export: true,
    ),
  ];
}
