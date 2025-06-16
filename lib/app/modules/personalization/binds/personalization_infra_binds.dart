import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/personalization_mobile_repository.dart';

import '../domain/repositories/personalization_repository.dart';
import '../infra/adapters/personalization_entity_adapter.dart';
import '../infra/adapters/personalization_entity_mobile_adapter.dart';
import '../infra/repositories/get_personalization_mobile_repository_imp.dart';
import '../infra/repositories/get_personalization_repository_imp.dart';

class PersonalizationInfraBinds {
  static List<Bind<Object>> binds = [
    // Adapters
    Bind.lazySingleton(
      (i) {
        return PersonalizationEntityAdapter();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return PersonalizationMobileEntityAdapter();
      },
      export: true,
    ),

    // Repositories
    Bind.lazySingleton<PersonalizationRepository>(
      (i) {
        return GetPersonalizationRepositoryImp(
          getPersonalizationDatasource: i.get(),
          
          personalizationEntityAdapter: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<PersonalizationMobileRepository>(
      (i) {
        return GetPersonalizationMobileRepositoryImp(
          getPersonalizationMobileDatasource: i.get(),
          
          getPersonalizationMobileDriver: i.get(),
          savePersonalizationMobileDriver: i.get(),
          personalizationMobileEntityAdapter: i.get(),
        );
      },
      export: true,
    ),
  ];
}
