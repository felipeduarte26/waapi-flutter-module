import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/ia_assist_usecase.dart';

class IAAssistDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.factory<IAAssistUsecase>(
      (i) {
        return IAAssistUsecaseImpl(
          iaAssistRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
