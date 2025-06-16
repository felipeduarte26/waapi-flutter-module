class OnboardingRoutes {
  /// Module route name
  static const String onboardingModuleRoute = '/onboarding';

  // Onboarding screen routes name
  static const String onboardingScreenRoute = '/';
  static const String onboardingScreenInitialRoute = '$onboardingModuleRoute$onboardingScreenRoute';

  // Tour screen routes name
  static const String tourScreenRoute = '/tour';
  static const String tourScreenInitialRoute = '$onboardingModuleRoute$tourScreenRoute';

  // Splash screen routes name
  static const String splashScreenRoute = '/splash';
  static const String splashScreenInitialRoute = '$onboardingModuleRoute$splashScreenRoute';
}
