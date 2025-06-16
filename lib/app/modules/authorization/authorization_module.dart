import 'package:flutter_modular/flutter_modular.dart';

import 'binds/authorization_domain_binds.dart';
import 'binds/authorization_external_binds.dart';
import 'binds/authorization_infra_binds.dart';
import 'binds/authorization_presenter_binds.dart';

class AuthorizationModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...AuthorizationDomainBinds.binds,
      ...AuthorizationInfraBinds.binds,
      ...AuthorizationExternalBinds.binds,
      ...AuthorizationPresenterBinds.binds,
    ];
  }
}
