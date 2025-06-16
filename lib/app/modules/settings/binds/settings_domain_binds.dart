import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_current_version_usecase.dart';

class SettingsDomainBinds {
  static List<Bind<Object>> binds = [
    // Drivers
    Bind.singleton<GetCurrentVersionUsecase>((i) {
      return GetCurrentVersionUsecaseImpl(
        getCurrentVersionRepository: i.get(),
      );
    }),
  ];
}
