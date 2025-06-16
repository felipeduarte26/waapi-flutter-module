import 'package:flutter_modular/flutter_modular.dart';

import '../../g5/external/datasources/get_g5_connector_datasource_impl.dart';
import '../../g5/infra/datasources/get_g5_connector_datasource.dart';

class G5ExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.factory<GetG5ConnectorDatasource>(
      (i) {
        return GetG5ConnectorDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),
  ];
}
