import 'package:flutter_modular/flutter_modular.dart';

import 'binds/has_clocking_binds.dart';

class HasClockingInstance extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...HasClockingBinds.binds,
    ];
  }
}
