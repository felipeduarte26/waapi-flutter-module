import 'package:flutter_modular/flutter_modular.dart';

import '../external/drivers/get_already_viewed_onboarding_driver_impl.dart';
import '../external/drivers/open_external_url_driver_impl.dart';
import '../external/drivers/save_already_viewed_onboarding_driver_impl.dart';
import '../infra/drivers/get_already_viewed_onboarding_driver.dart';
import '../infra/drivers/open_external_url_driver.dart';
import '../infra/drivers/save_already_viewed_onboarding_driver.dart';

class OnboardingExternalBinds {
  static List<Bind<Object>> binds = [
    // Drivers
    Bind.lazySingleton<SaveAlreadyViewedOnboardingDriver>(
      (i) {
        return SaveAlreadyViewedOnboardingDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetAlreadyViewedOnboardingDriver>(
      (i) {
        return GetAlreadyViewedOnboardingDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<OpenExternalUrlDriver>(
      (i) {
        return OpenExternalUrlDriverImpl(
          openExternalUrlService: i.get(),
        );
      },
      export: true,
    ),
  ];
}
