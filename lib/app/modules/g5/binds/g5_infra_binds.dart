import 'package:flutter_modular/flutter_modular.dart';

import '../../g5/domain/repositories/get_g5_connector_repository.dart';
import '../../g5/infra/repositoories/get_g5_connector_repository_impl.dart';

class G5InfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.factory<GetG5ConnectorRepository>(
      (i) {
        return GetG5ConnectorRepositoryImpl(
          
          getG5ConnectorDatasource: i.get(),
        );
      },
      export: true,
    ),
  ];
}
