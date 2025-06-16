import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import 'binds/onboarding_domain_binds.dart';
import 'binds/onboarding_external_binds.dart';
import 'binds/onboarding_infra_binds.dart';
import 'binds/onboarding_presenter_binds.dart';
import 'presenter/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'presenter/screens/onboarding_screen/onboarding_screen.dart';
import 'presenter/screens/splash_screen/splash_screen.dart';
import 'presenter/screens/tour_screen/tour_screen.dart';

class OnboardingModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...OnboardingDomainBinds.binds,
      ...OnboardingInfraBinds.binds,
      ...OnboardingExternalBinds.binds,
      ...OnboardingPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        OnboardingRoutes.onboardingScreenRoute,
        transition: TransitionType.noTransition,
        child: (_, __) {
          return OnboardingScreen(
            onboardingBloc: Modular.get<OnboardingBloc>(),
          );
        },
      ),
      ChildRoute(
        OnboardingRoutes.tourScreenRoute,
        transition: TransitionType.noTransition,
        child: (_, args) {
          return TourScreen(
            onboardingBloc: Modular.get<OnboardingBloc>(),
            isReview: args.data?['isReview'] ?? false,
          );
        },
      ),
      ChildRoute(
        OnboardingRoutes.splashScreenRoute,
        transition: TransitionType.fadeIn,
        child: (_, args) {
          return SplashScreen(
            onboardingBloc: Modular.get(),
          );
        },
      ),
    ];
  }
}
