import 'package:flutter_modular/flutter_modular.dart';

import 'binds/g5_domain_binds.dart';
import 'binds/g5_external_binds.dart';
import 'binds/g5_infra_binds.dart';
import 'binds/g5_presenter_binds.dart';

class G5Module extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...G5DomainBinds.binds,
      ...G5ExternalBinds.binds,
      ...G5InfraBinds.binds,
      ...G5PresenterBinds.binds,
    ];
  }
}
