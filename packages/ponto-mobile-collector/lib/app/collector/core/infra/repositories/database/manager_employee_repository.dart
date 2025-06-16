// ignore_for_file: void_checks

import '../../../domain/repositories/database/imanager_employee_repository.dart';
import '../../../external/drift/collector_database.dart';

class ManagerEmployeeRepository implements IManagerEmployeeRepository {
  CollectorDatabase database;

  ManagerEmployeeRepository({
    required this.database,
  });

  @override
  Future<bool> exist({
    required String managerId,
    required String employeeId,
  }) async {
    final query = database.select(database.employeeManagersTable);
    query.where((tbl) => tbl.managerId.equals(managerId));
    query.where((tbl) => tbl.employeeId.isValue(employeeId));
    EmployeeManagersTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required String managerId,
    required String employeeId,
  }) async {
    EmployeeManagersTableData tableData =
        convertToTable(managerId: managerId, employeeId: employeeId);
    return database.into(database.employeeManagersTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required String managerId,
    required String employeeId,
  }) async {
    final EmployeeManagersTableData updatedData =
        convertToTable(managerId: managerId, employeeId: employeeId);

    final affectedRows = await (database.update(database.employeeManagersTable)
          ..where((tbl) => tbl.employeeId.equals(employeeId))
          ..where((tbl) => tbl.managerId.equals(managerId)))
        .write(updatedData);

    return affectedRows > 0;
  }

  @override
  Future<bool> save({
    required String managerId,
    required String employeeId,
  }) async {
    if (!await existManagerByEmployeeId(employeeId: employeeId)) {
      await insert(managerId: managerId, employeeId: employeeId);
    } else {
      await update(managerId: managerId, employeeId: employeeId);
    }

    return true;
  }

  @override
  EmployeeManagersTableData convertToTable({
    required String managerId,
    required String employeeId,
  }) {
    EmployeeManagersTableData tableData = EmployeeManagersTableData(
      managerId: managerId,
      employeeId: employeeId,
    );

    return tableData;
  }

  @override
  Future<void> deleteByEmployeeId({required String employeeId}) async {
    final query = database.delete(database.employeeManagersTable);
    query.where((tbl) => tbl.employeeId.isValue(employeeId));
    return Future.value(query.go());
  }

  @override
  Future<bool> existManagerByEmployeeId({required String employeeId}) async {
    List<EmployeeManagersTableData> managerEmployees =
        await (database.select(database.employeeManagersTable)
              ..where((tbl) => tbl.employeeId.equals(employeeId)))
            .get();
    if (managerEmployees.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<List<EmployeeManagersTableData>> getAll() async {
    List<EmployeeManagersTableData> managerEmployees =
        await (database.select(database.employeeManagersTable)).get();
    return managerEmployees;
  }

  @override
  Future<void> deleteAll() async {
    await database.delete(database.employeeManagersTable).go();
  }

  @override
  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.employeeManagersTable);
    query.where((tbl) => tbl.employeeId.isIn(employeeIds));

    await query.go();
  }
}
