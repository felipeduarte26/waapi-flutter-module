import 'package:flutter_modular/flutter_modular.dart';

import '../../g5/domain/usecases/get_g5_connector_usecase.dart';

class G5DomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.factory<GetG5ConnectorUsecase>(
      (i) {
        return GetG5ConnectorUsecaseImpl(
          getG5ConnectorRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
