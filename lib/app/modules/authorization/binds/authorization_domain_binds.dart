import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_user_authorizations_usecase.dart';

class AuthorizationDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.lazySingleton<GetUserAuthorizationsUsecase>(
      (i) {
        return GetUserAuthorizationsUsecaseImpl(
          authorizationRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
