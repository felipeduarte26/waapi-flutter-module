abstract class HyperlinkRoutes {
  // Module route name
  static const String hyperlinkModuleRoute = '/hyperlink';

  // Hyperlink screen routes name
  static const String hyperlinkScreenRoute = '/';
  static const String hyperlinkScreenInitialRoute = '$hyperlinkModuleRoute$hyperlinkScreenRoute';

  // Hyperlink state screen routes name
  static const String hyperlinkStateScreenRoute = '/state';
  static const String hyperlinkStateScreenInitialRoute = '$hyperlinkModuleRoute$hyperlinkStateScreenRoute';

  // Hyperlink selected screen routes name
  static const String hyperlinkSelectedScreenRoute = '/selected';
  static const String hyperlinkSelectedScreenInitialRoute = '$hyperlinkModuleRoute$hyperlinkSelectedScreenRoute';
}
