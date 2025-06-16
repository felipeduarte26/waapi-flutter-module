import 'package:flutter_modular/flutter_modular.dart';

import 'binds/active_contract_domain_binds.dart';
import 'binds/active_contract_external_binds.dart';
import 'binds/active_contract_infra_binds.dart';
import 'binds/active_contract_presenter_binds.dart';

class ActiveContractModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...ActiveContractDomainBinds.binds,
      ...ActiveContractInfraBinds.binds,
      ...ActiveContractExternalBinds.binds,
      ...ActiveContractPresenterBinds.binds,
    ];
  }
}
