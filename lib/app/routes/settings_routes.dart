abstract class SettingsRoutes {
  // Module route name
  static const String settingsModuleRoute = '/settings';

  // Settings screen routes name
  static const String settingsScreenRoute = '/';
  static const String settingsScreenInitialRoute = '$settingsModuleRoute$settingsScreenRoute';

  // Settings Biometric screen routes
  static const String settingsBiometricScreenRoute = '/biometric';
  static const String settingsBiometricScreenInitialRoute = '$settingsModuleRoute$settingsBiometricScreenRoute';
}
