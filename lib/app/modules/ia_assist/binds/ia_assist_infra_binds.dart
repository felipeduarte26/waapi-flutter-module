import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/ia_assist_repository.dart';
import '../infra/repositories/ia_assist_repository_impl.dart';

class IAAssistInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.factory<IAAssistRepository>(
      (i) {
        return IAAssistRepositoryImpl(
          
          iaAssistDatasource: i.get(),
        );
      },
      export: true,
    ),
  ];
}
