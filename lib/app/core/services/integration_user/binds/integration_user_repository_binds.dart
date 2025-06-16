import 'package:flutter_modular/flutter_modular.dart';

import '../data/integration_user_repository.dart';
import '../infra/repositories/integration_user_repository_impl.dart';

class IntegrationUserBinds {
  static List<Bind<Object>> binds = [
    Bind.lazySingleton<IntegrationUserRepository>(
      (i) {
        return IntegrationUserRepositoryImpl(internalStorageService: i.get());
      },
      export: true,
    ),
  ];
}
