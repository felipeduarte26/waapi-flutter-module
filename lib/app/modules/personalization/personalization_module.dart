import 'package:flutter_modular/flutter_modular.dart';

import 'binds/personalization_domain_binds.dart';
import 'binds/personalization_external_binds.dart';
import 'binds/personalization_infra_binds.dart';
import 'binds/personalization_presenter_binds.dart';

class PersonalizationModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...PersonalizationDomainBinds.binds,
      ...PersonalizationInfraBinds.binds,
      ...PersonalizationExternalBinds.binds,
      ...PersonalizationPresenterBinds.binds,
    ];
  }
}
