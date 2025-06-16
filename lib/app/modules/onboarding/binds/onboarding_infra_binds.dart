import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_already_viewed_onboarding_repository.dart';
import '../domain/repositories/open_external_url_repository.dart';
import '../domain/repositories/save_already_viewed_onboarding_repository.dart';
import '../domain/repositories/set_onboarding_jump_repository.dart';
import '../infra/repositories/get_already_viewed_onboarding_repository_impl.dart';
import '../infra/repositories/open_external_url_repository_impl.dart';
import '../infra/repositories/save_already_viewed_onboarding_repository_impl.dart';
import '../infra/repositories/set_onboarding_jump_repository_impl.dart';

class OnboardingInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.lazySingleton<GetAlreadyViewedOnboardingRepository>(
      (i) {
        return GetAlreadyViewedOnboardingRepositoryImpl(
          getAlreadyViewedOnboardingDriver: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveAlreadyViewedOnboardingRepository>(
      (i) {
        return SaveAlreadyViewedOnboardingRepositoryImpl(
          saveAlreadyViewedOnboardingDriver: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SetOnboardingJumpRepository>(
      (i) {
        return SetOnboardingJumpRepositoryImpl(
          saveAlreadyViewedOnboardingDriver: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<OpenExternalUrlRepository>(
      (i) {
        return OpenExternalUrlRepositoryImpl(
          openExternalUrlDriver: i.get(),
        );
      },
      export: true,
    ),
  ];
}
