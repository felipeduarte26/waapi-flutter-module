import '../../external/drift/collector_database.dart';

abstract class GetLogsRepository {
  Future<List<LogsTableData>> call();
}
