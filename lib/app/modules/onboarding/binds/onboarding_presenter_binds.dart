import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/onboarding_bloc/onboarding_bloc.dart';
import '../presenter/screens/onboarding_screen/bloc/onboarding_screen_bloc.dart';
import '../presenter/screens/splash_screen/bloc/splash_bloc.dart';

class OnboardingPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.factory(
      (i) {
        return OnboardingBloc(
          getAlreadyViewedOnboardingUsecase: i.get(),
          saveAlreadyViewedOnboardingUsecase: i.get(),
          setOnboardingJumpUsecase: i.get(),
          openExternalUrlUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return OnboardingScreenBloc(
          onboardingBloc: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return SplashBloc();
      },
      export: true,
    ),
  ];
}
