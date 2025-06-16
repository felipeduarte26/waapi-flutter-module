import 'package:drift/drift.dart';

import '../../../domain/repositories/database/iemployee_platform_user_repository.dart';
import '../../../external/drift/collector_database.dart';

class EmployeePlatformUserRepository
    implements IEmployeePlatformUserRepository {
  CollectorDatabase database;

  EmployeePlatformUserRepository({
    required this.database,
  });

  @override
  Future<bool> exist({
    required String platformUserId,
    required String employeeId,
  }) async {
    final query = database.select(database.employeePlatformUsersTable);
    query.where((tbl) => tbl.platforUsersId.equals(platformUserId));
    query.where((tbl) => tbl.employeeId.equals(employeeId));
    EmployeePlatformUsersTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required String platformUserId,
    required String employeeId,
  }) async {
    EmployeePlatformUsersTableData tableData =
        convertToTable(platformUserId: platformUserId, employeeId: employeeId);
    return database.into(database.employeePlatformUsersTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required String platformUserId,
    required String employeeId,
    required String newPlatformUserId,
  }) async {
    final updatedData = EmployeePlatformUsersTableCompanion(
      platforUsersId: Value(newPlatformUserId),
      employeeId: Value(employeeId),
    );

    final affectedRows =
        await (database.update(database.employeePlatformUsersTable)
              ..where((tbl) => tbl.platforUsersId.equals(platformUserId))
              ..where((tbl) => tbl.employeeId.equals(employeeId)))
            .write(updatedData);

    return affectedRows > 0;
  }

  @override
  Future<bool> save({
    required String platformUserId,
    required String employeeId,
  }) async {
    if (!await exist(platformUserId: platformUserId, employeeId: employeeId)) {
      await insert(platformUserId: platformUserId, employeeId: employeeId);
    } else {
      await update(
        platformUserId: platformUserId,
        employeeId: employeeId,
        newPlatformUserId: platformUserId,
      );
    }

    return true;
  }

  @override
  Future<EmployeePlatformUsersTableData?> findByPlatformUserId({
    required String platformUserId,
  }) async {
    EmployeePlatformUsersTableData? employeePlatformUsersTable =
        await (database.select(database.employeePlatformUsersTable)
              ..where((tbl) => tbl.platforUsersId.equals(platformUserId)))
            .getSingleOrNull();

    return employeePlatformUsersTable;
  }

  @override
  Future<void> deleteAll() async {
    await database.delete(database.employeePlatformUsersTable).go();
  }

  @override
  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.employeePlatformUsersTable);
    query.where((tbl) => tbl.employeeId.isIn(employeeIds));

    await query.go();
  }

  @override
  EmployeePlatformUsersTableData convertToTable({
    required String platformUserId,
    required String employeeId,
  }) {
    EmployeePlatformUsersTableData tableData = EmployeePlatformUsersTableData(
      platforUsersId: platformUserId,
      employeeId: employeeId,
    );

    return tableData;
  }
}
