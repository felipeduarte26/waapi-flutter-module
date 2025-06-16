import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_current_version_repository.dart';
import '../infra/repositories/get_current_version_repository_impl.dart';

class SettingsInfraBinds {
  static List<Bind<Object>> binds = [
    // Drivers
    Bind.singleton<GetCurrentVersionRepository>((i) {
      return GetCurrentVersionRepositoryImpl(
        getCurrentVersionDriver: i.get(),
        
      );
    }),
  ];
}
