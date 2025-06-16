import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/authorization_repository.dart';
import '../infra/adapters/authorization_entity_adapter.dart';
import '../infra/adapters/social_authorization_entity_adapter.dart';
import '../infra/repositories/authorization_repository_impl.dart';

class AuthorizationInfraBinds {
  static List<Bind<Object>> binds = [
    // Adapters
    Bind.lazySingleton(
      (i) {
        return AuthorizationEntityAdapter();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return SocialAuthorizationEntityAdapter();
      },
      export: true,
    ),

    // Repositories
    Bind.lazySingleton<AuthorizationRepository>(
      (i) {
        return AuthorizationRepositoryImpl(
          legacyAuthorizationsDatasource: i.get(),
          platformAuthorizationsDatasource: i.get(),
          authorizationEntityMapper: i.get(),
          
          featureControlAuthorizationsDatasource: i.get(),
          activeTenantModulesDatasource: i.get(),
          saveWaapiLiteDriver: i.get(),
          getWaapiLiteDriver: i.get(),
          saveHasClockingDriver: i.get(),
          saveClockingConfigurationDriver: i.get(),
          getHasClockingDriver: i.get(),
          internalStorageService: i.get(),
          restService: i.get(),
  
        );
      },
      export: true,
    ),
  ];
}
