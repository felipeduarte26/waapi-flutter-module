import 'package:flutter_modular/flutter_modular.dart';

import '../external/drivers/get_current_version_driver_impl.dart';
import '../infra/drivers/get_current_version_driver.dart';

class SettingsExternalBinds {
  static List<Bind<Object>> binds = [
    // Drivers
    Bind.singleton<GetCurrentVersionDriver>((i) {
      return GetCurrentVersionDriverImpl();
    }),
  ];
}
