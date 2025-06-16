import '../../../../../../ponto_mobile_collector.dart';
import '../../../external/drift/collector_database.dart';

class EmployeeFenceRepository implements IEmployeeFenceRepository {
  CollectorDatabase database;

  EmployeeFenceRepository({required this.database});

  @override
  Future<bool> exist({
    required String employeeId,
    required String fenceId,
  }) async {
    final query = database.select(database.employeeFenceTable);
    query.where((tbl) => tbl.employeeId.equals(employeeId));
    query.where((tbl) => tbl.fenceId.equals(fenceId));
    EmployeeFenceTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required String employeeId,
    required String fenceId,
  }) async {
    EmployeeFenceTableData configTable = convertToTable(
      fenceId: fenceId,
      employeeId: employeeId,
    );

    return database.into(database.employeeFenceTable).insert(configTable);
  }

  @override
  Future<bool> save({
    required String employeeId,
    required String fenceId,
  }) async {
    return (await exist(employeeId: employeeId, fenceId: fenceId))
        ? true
        : (await insert(employeeId: employeeId, fenceId: fenceId)) > 0;
  }

  @override
  Future<List<String>> findAllByEmployeeId({required String employeeId}) async {
    final query = database.select(database.employeeFenceTable);
    query.where((tbl) => tbl.employeeId.equals(employeeId));

    List<EmployeeFenceTableData> datas = await query.get();

    List<String> fencesId = [];
    for (EmployeeFenceTableData tableData in datas) {
      fencesId.add(tableData.fenceId);
    }

    return fencesId;
  }

  @override
  Future<void> deleteAll() async {
    await database.delete(database.employeeFenceTable).go();
  }

  @override
  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.employeeFenceTable);
    query.where((tbl) => tbl.employeeId.isIn(employeeIds));

    await query.go();
  }

  @override
  EmployeeFenceTableData convertToTable({
    required String employeeId,
    required String fenceId,
  }) {
    EmployeeFenceTableData tableData = EmployeeFenceTableData(
      fenceId: fenceId,
      employeeId: employeeId,
    );

    return tableData;
  }
}
