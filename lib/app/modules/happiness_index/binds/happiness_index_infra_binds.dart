import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/helper/enum_helper.dart';
import '../domain/repositories/get_mood_records_repository.dart';
import '../domain/repositories/happiness_index_is_enabled_repository.dart';
import '../domain/repositories/retrieve_all_reasons_happiness_index_repository.dart';
import '../domain/repositories/save_happiness_index_repository.dart';
import '../enums/happiness_index_mood_enum.dart';
import '../infra/adapters/happiness_index_group_entity_adapter.dart';
import '../infra/adapters/happiness_index_mood_entity_adapter.dart';
import '../infra/repositories/get_mood_records_repository_impl.dart';
import '../infra/repositories/happiness_index_is_enabled_repository_impl.dart';
import '../infra/repositories/retrieve_all_reasons_happiness_index_repository_impl.dart';
import '../infra/repositories/save_happiness_index_repository_impl.dart';

class HappinessIndexInfraBinds {
  static List<Bind<Object>> binds = [
    // Enums
    Bind.factory(
      (i) {
        return EnumHelper<HappinessIndexMoodEnum>();
      },
      export: true,
    ),

    // Repositories
    Bind.lazySingleton<SaveHappinessIndexRepository>(
      (i) {
        return SaveHappinessIndexRepositoryImpl(
          saveHappinessIndexDatasource: i.get(),
          enumHelper: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<HappinessIndexIsEnabledRepository>(
      (i) {
        return HappinessIndexIsEnabledRepositoryImpl(
          happinessIndexIsEnabledDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<RetrieveAllReasonsHappinessIndexRepository>(
      (i) {
        return RetrieveAllReasonsHappinessIndexRepositoryImpl(
          groupEntityAdapter: i.get(),
          retrieveAllReasonsHappinessIndexDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetMoodRecordsRepository>(
      (i) {
        return GetMoodRecordsRepositoryImpl(
          getMoodRecordsDatasource: i.get(),
          happinessIndexMoodEntityAdapter: i.get(),
        );
      },
      export: true,
    ),

    // Adapters
    Bind.lazySingleton(
      (i) {
        return HappinessIndexGroupEntityAdapter();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return HappinessIndexMoodEntityAdapter();
      },
      export: true,
    ),
  ];
}
