class ManagementPanelRoutes {
  /// Module route name
  static const String managementPanelModuleRoute = '/managementPanel';

  //managementPanelRecentFeedbackTextError screen routes name
  static const String managementPanelScreenRoute = '/';
  static const String managementPanelScreenInitialRoute = '$managementPanelModuleRoute$managementPanelScreenRoute';

  //underDevelopment screen routes name
  static const String underDevelopmentScreenRoute = '/underDevelopment';
  static const String toUnderDevelopmentScreenRoute = '$managementPanelModuleRoute$underDevelopmentScreenRoute';

  static const String documentationHappinessScreenRoute = '/documentationHappinessScreenIndex';
  static const String toDocumentationHappinessScreenRoute =
      '$managementPanelModuleRoute$documentationHappinessScreenRoute';

  static const String documentationWaapiLiteScreenRoute = '/documentationWaapiLiteScreen';
  static const String toDocumentationWaapiLiteScreenRoute =
      '$managementPanelModuleRoute$documentationWaapiLiteScreenRoute';
}
