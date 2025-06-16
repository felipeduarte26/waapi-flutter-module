import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/get_moods_pulse_link_datasource_impl.dart';
import '../infra/datasources/get_moods_pulse_link_datasource.dart';

class MoodsExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.lazySingleton<GetMoodsPulseLinkDatasource>(
      (i) {
        return GetMoodsPulseLinkDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),
  ];
}
