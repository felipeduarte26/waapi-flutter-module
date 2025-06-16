import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/happiness_index/happiness_index_bloc.dart';
import '../presenter/blocs/retrieve_all_reasons/retrieve_all_reasons_bloc.dart';
import '../presenter/blocs/retrieve_mood_records/retrieve_mood_records_bloc.dart';
import '../presenter/screens/blocs/happiness_index_screen_bloc.dart';
import '../presenter/screens/happiness_index_report/bloc/happiness_index_report_screen_bloc.dart';

class HappinessIndexPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.lazySingleton(
      (i) {
        return HappinessIndexBloc(
          getCurrentHappinessIndexUsecase: i.get(),
          saveHappinessIndexUsecase: i.get(),
          happinessIndexIsEnabledUsecase: i.get(),
          
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return RetrieveAllReasonsBloc(
          retrieveAllReasonsUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return HappinessIndexScreenBloc(
          happinessIndexBloc: i.get(),
          retrieveAllReasonsBloc: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return RetrieveMoodRecordsBloc(
          getMoodRecordsUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return HappinessIndexReportScreenBloc(
          retrieveMoodRecordsBloc: i.get(),
        );
      },
    ),
  ];
}
