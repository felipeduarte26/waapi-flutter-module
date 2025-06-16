import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_already_viewed_onboarding_usecase.dart';
import '../domain/usecases/open_external_url_usecase.dart';
import '../domain/usecases/save_already_viewed_onboarding_usecase.dart';
import '../domain/usecases/set_onboarding_jump_usecase.dart';

class OnboardingDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.lazySingleton<GetAlreadyViewedOnboardingUsecase>(
      (i) {
        return GetAlreadyViewedOnboardingUsecaseImpl(
          getAlreadyViewedOnboardingRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveAlreadyViewedOnboardingUsecase>(
      (i) {
        return SaveAlreadyViewedOnboardingUsecaseImpl(
          saveAlreadyViewedOnboardingRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SetOnboardingJumpUsecase>(
      (i) {
        return SetOnboardingJumpUsecaseImpl(
          setOnboardingJumpRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<OpenExternalUrlUsecase>(
      (i) {
        return OpenExternalUrlUsecaseImpl(
          openExternalUrlRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
