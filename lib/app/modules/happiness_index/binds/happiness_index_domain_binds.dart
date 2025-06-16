import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_current_happiness_index_usecase.dart';
import '../domain/usecases/get_mood_records_usecase.dart';
import '../domain/usecases/happiness_index_is_enabled_usecase.dart';
import '../domain/usecases/retrieve_all_reasons_happiness_index_usecase.dart';
import '../domain/usecases/save_happiness_index_usecase.dart';

class HappinessIndexDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.lazySingleton<GetCurrentHappinessIndexUsecase>(
      (i) {
        return GetCurrentHappinessIndexUsecaseImpl(
          getMoodRecordsUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveHappinessIndexUsecase>(
      (i) {
        return SaveHappinessIndexUsecaseImpl(
          saveHappinessIndexRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<HappinessIndexIsEnabledUsecase>(
      (i) {
        return HappinessIndexIsEnabledUsecaseImpl(
          happinessIndexIsEnabledRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<RetrieveAllReasonsHappinessIndexUsecase>(
      (i) {
        return RetrieveAllReasonsHappinessIndexUsecaseImpl(
          retrieveAllReasonsHappinessIndexRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetMoodRecordsUsecase>(
      (i) {
        return GetMoodRecordsUsecaseImpl(
          getMoodRecordsRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
