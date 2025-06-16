import 'package:flutter_modular/flutter_modular.dart';

import 'binds/ia_assist_domain_binds.dart';
import 'binds/ia_assist_external_binds.dart';
import 'binds/ia_assist_infra_binds.dart';
import 'binds/ia_assist_presenter_binds.dart';

class IAAssistModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...IAAssistDomainBinds.binds,
      ...IAAssistExternalBinds.binds,
      ...IAAssistInfraBinds.binds,
      ...IAAssistPresenterBinds.binds,
    ];
  }
}
