import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasource/get_personalization_datasource_imp.dart';
import '../external/datasource/get_personalization_mobile_datasource_imp.dart';
import '../external/driver/clean_personalization_mobile_driver_impl.dart';
import '../external/driver/get_personalization_mobile_driver_impl.dart';
import '../external/driver/save_personalization_mobile_driver_impl.dart';
import '../external/mappers/personalization_mobile_model_mapper.dart';
import '../external/mappers/personalization_model_mapper.dart';
import '../infra/datasources/get_personalization_datasource.dart';
import '../infra/datasources/get_personalization_mobile_datasource.dart';
import '../infra/driver/clean_personalization_mobile_driver.dart';
import '../infra/driver/get_personalization_mobile_driver.dart';
import '../infra/driver/save_personalization_mobile_driver.dart';

class PersonalizationExternalBinds {
  static List<Bind<Object>> binds = [
    // Mappers
    Bind.lazySingleton(
      (i) {
        return PersonalizationModelMapper();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return PersonalizationMobileModelMapper();
      },
      export: true,
    ),

    //datasource
    Bind.lazySingleton<GetPersonalizationDatasource>(
      (i) {
        return GetPersonalizationDatasourceImp(
          restService: i.get(),
          personalizationModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetPersonalizationMobileDatasource>(
      (i) {
        return GetPersonalizationMobileDatasourceImp(
          restService: i.get(),
          personalizationMobileModelMapper: i.get(),
        );
      },
      export: true,
    ),

    //Drivers

    Bind.lazySingleton<GetPersonalizationMobileDriver>(
      (i) {
        return GetPersonalizationMobileDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SavePersonalizationMobileDriver>(
      (i) {
        return SavePersonalizationMobileDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),
    Bind.factory<CleanPersonalizationMobileDriver>(
      (i) {
        return CleanPersonalizationMobileDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),
  ];
}
