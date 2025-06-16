import '../../../domain/entities/crash_log.dart';
import '../../../domain/repositories/database/logs_repository_db.dart';
import '../../../domain/repositories/sync_logs_api_repository.dart';
import '../../../domain/services/logs/send_logs_service.dart.dart';

class SendLogsServiceImpl implements SendLogsService {
  LogsRepositoryDb logsRepositoryDb;
  SyncLogsApiRepository logsRepository;

  SendLogsServiceImpl({
    required this.logsRepositoryDb,
    required this.logsRepository,
  });

  @override
  Future<void> sendLog({required CrashLog crashLog}) async {
    await logsRepositoryDb.insert(crashLog: crashLog);
  }
}
