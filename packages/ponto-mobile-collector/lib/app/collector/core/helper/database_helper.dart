import '../external/drift/collector_database.dart';

abstract class IDatabaseHelper {
  Future<void> transaction({
    required Future<void> Function() transaction,
  });
}

class DatabaseHelper implements IDatabaseHelper {
  final CollectorDatabase _database;

  const DatabaseHelper({
    required CollectorDatabase database,
  }) : _database = database;

  @override
  Future<void> transaction({
    required Future<void> Function() transaction,
  }) async {
    await _database.transaction(transaction);
  }
}
