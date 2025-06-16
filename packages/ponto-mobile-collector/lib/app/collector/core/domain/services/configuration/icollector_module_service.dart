import '../../../../../../ponto_mobile_collector.dart';

abstract class ICollectorModuleService {
  /// Initialization service, call this method before using library features
  Future<void> initialize({
    required EnvironmentEnum environment,
    required AppIdentfierEnum appIdentifier,
    String fcmToken,
    bool hideBackButton = true,
    bool showNotificationButton = true,
    required String homePath,
    required String loginPath,
  });
  bool hasInitialized();
  Future<void> finalize();
  String getHomePath();
  String getLoginPath();
  void setHomePath(String home);
  AppIdentfierEnum getAppIdentfierEnum();
}
