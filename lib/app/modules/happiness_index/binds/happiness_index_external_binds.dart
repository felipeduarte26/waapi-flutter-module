import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/get_mood_records_datasource_impl.dart';
import '../external/datasources/happiness_index_is_enabled_datasource_impl.dart';
import '../external/datasources/retrieve_all_reasons_happiness_index_datasource_impl.dart';
import '../external/datasources/save_happiness_index_datasource_impl.dart';
import '../external/mappers/happiness_index_group_model_mapper.dart';
import '../external/mappers/happiness_index_mood_model_mapper.dart';
import '../external/mappers/happiness_index_reason_model_mapper.dart';
import '../external/mappers/happiness_index_subgroup_model_mapper.dart';
import '../infra/datasources/get_mood_records_datasource.dart';
import '../infra/datasources/happiness_index_is_enabled_datasource.dart';
import '../infra/datasources/retrieve_all_reasons_happiness_index_datasource.dart';
import '../infra/datasources/save_happiness_index_datasource.dart';

class HappinessIndexExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.lazySingleton<SaveHappinessIndexDatasource>(
      (i) {
        return SaveHappinessIndexDatasourceImpl(
          enumHelper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<HappinessIndexIsEnabledDatasource>(
      (i) {
        return HappinessIndexIsEnabledDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<RetrieveAllReasonsHappinessIndexDatasource>(
      (i) {
        return RetrieveAllReasonsHappinessIndexDatasourceImpl(
          groupModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetMoodRecordsDatasource>(
      (i) {
        return GetMoodRecordsDatasourceImpl(
          happinessIndexMoodModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    //Mappers
    Bind.factory(
      (i) {
        return HappinessIndexGroupModelMapper(
          subgroupModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return HappinessIndexSubgroupModelMapper(
          reasonModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return HappinessIndexReasonModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return HappinessIndexMoodModelMapper(
          groupModelMapper: i.get(),
        );
      },
      export: true,
    ),
  ];
}
