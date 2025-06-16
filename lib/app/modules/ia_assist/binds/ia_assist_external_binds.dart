import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/ia_assist_datasource_impl.dart';
import '../infra/datasources/ia_assist_datasource.dart';

class IAAssistExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.factory<IAAssistDatasource>(
      (i) {
        return IAAssistDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),
  ];
}
