import '../../entities/crash_log.dart';

abstract class SendLogsService {
  Future<void> sendLog({required CrashLog crashLog});
}
