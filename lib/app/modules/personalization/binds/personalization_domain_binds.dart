import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usercases/clean_personalization_mobile_driver_usecase.dart';
import '../domain/usercases/get_personalization_mobile_usecase.dart';
import '../domain/usercases/get_personalization_usecase.dart';

class PersonalizationDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.lazySingleton<GetPersonalizationUsecase>(
      (i) {
        return GetPersonalizationUsecaseImpl(
          personalizationRepository: i.get(),
        );
      },
      export: true,
    ),
    Bind.lazySingleton<GetPersonalizationMobileUsecase>(
      (i) {
        return GetPersonalizationMobileUsecaseImpl(
          personalizationMobileRepository: i.get(),
        );
      },
      export: true,
    ),
    Bind.factory<CleanPersonalizationMobileDriverUsecase>(
      (i) {
        return CleanPersonalizationMobileDriverUsecaseImpl(
          cleanPersonalizationMobileDriver: i.get(),
        );
      },
      export: true,
    ),
   
  ];
}
