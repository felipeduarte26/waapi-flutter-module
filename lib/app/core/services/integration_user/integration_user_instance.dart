import 'package:flutter_modular/flutter_modular.dart';

import 'binds/integration_user_repository_binds.dart';

class IntegrationUserInstance extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...IntegrationUserBinds.binds,
    ];
  }
}
