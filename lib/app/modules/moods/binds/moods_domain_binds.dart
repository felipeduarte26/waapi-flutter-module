import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_moods_pulse_link_usecase.dart';

class MoodsDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.lazySingleton<GetMoodsPulseLinkUsecase>(
      (i) {
        return GetMoodsPulseLinkUsecaseImpl(
          getMoodsPulseLinkRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
