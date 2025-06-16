import 'package:flutter_modular/flutter_modular.dart';

import '../corporate_mural/binds/corporate_mural_domain_binds.dart';
import '../corporate_mural/binds/corporate_mural_external_binds.dart';
import '../corporate_mural/binds/corporate_mural_infra_binds.dart';
import '../corporate_mural/binds/corporate_mural_presenter_binds.dart';

class CorporateMuralModule extends Module {
  @override
  List<Bind> get binds {
    return [
      ...CorporateMuralDomainBinds.binds,
      ...CorporateMuralInfraBinds.binds,
      ...CorporateMuralExternalBinds.binds,
      ...CorporateMuralPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [];
  }
}
