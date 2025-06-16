
import '../../../../../../ponto_mobile_collector.dart';

abstract class IEnvironmentService {
  bool showDebugBanner();
  String platformUrlBase();
  bool registerFcmToken();
  EnvironmentEnum environment();
  bool byPassSslVerification();
  int syncBatchSize();
  String encryptionKey();
}
