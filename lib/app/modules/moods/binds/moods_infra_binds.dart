import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_moods_pulse_link_repository.dart';
import '../infra/repositories/get_pulse_link_repository_impl.dart';

class MoodsInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.lazySingleton<GetMoodsPulseLinkRepository>(
      (i) {
        return GetMoodsPulseLinkRepositoryImpl(
          
          getMoodsPulseLinkDatasource: i.get(),
        );
      },
      export: true,
    ),
  ];
}
