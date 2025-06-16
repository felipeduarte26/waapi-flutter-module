import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../domain/entities/manager_employee.dart';
import '../../../domain/repositories/database/imanager_employee_repository.dart';
import '../../../domain/repositories/database/imanager_platform_user_repository.dart';
import '../../../domain/repositories/database/imanager_repository.dart';
import '../../../external/drift/collector_database.dart';

class ManagerRepository implements IManagerRepository {
  CollectorDatabase database;
  final IManagerPlatformUserRepository managerPlatformUserRepository;
  final IManagerEmployeeRepository managerEmployeeRepository;

  ManagerRepository({
    required this.database,
    required this.managerPlatformUserRepository,
    required this.managerEmployeeRepository,
  });

  @override
  Future<bool> exist({
    required String managerId,
  }) async {
    final query = database.select(database.managerTable);
    query.where((tbl) => tbl.id.equals(managerId));
    ManagerTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required ManagerEmployee manager,
  }) async {
    ManagerTableData dataTable = convertToTable(
      manager: manager,
    );

    return database.into(database.managerTable).insert(dataTable);
  }

  @override
  Future<bool> update({
    required ManagerEmployee manager,
  }) async {
    ManagerTableData dataTable = convertToTable(
      manager: manager,
    );

    return database.update(database.managerTable).replace(dataTable);
  }

  @override
  Future<bool> save({
    required ManagerEmployee managerDto,
  }) async {
    // Save employee
    if (managerDto.id != null) {
      (await exist(managerId: managerDto.id!))
          ? await update(manager: managerDto)
          : await insert(manager: managerDto);
    }
    return true;
  }

  @override
  Future<clock.ManagerEmployeeDto?> findById({
    required String id,
  }) async {
    ManagerTableData? tableData = await (database.select(database.managerTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    return await loadComplementAndConvert(tableData);
  }

  @override
  Future<clock.ManagerEmployeeDto?> findByMail({
    required String mail,
  }) async {
    ManagerTableData? tableData = await (database.select(database.managerTable)
          ..where((tbl) => tbl.mail.equals(mail)))
        .getSingleOrNull();

    return loadComplementAndConvert(tableData);
  }

  Future<clock.ManagerEmployeeDto?> loadComplementAndConvert(
    ManagerTableData? tableData,
  ) async {
    if (tableData == null) {
      return null;
    }

    return convertToDto(
      tableData: tableData,
    );
  }

  @override
  Future<void> deleteAll() async {
    await database.delete(database.managerTable).go();
  }

  @override
  Future<List<clock.ManagerEmployeeDto>> getAll() async {
    List<ManagerTableData> tableDatas = await database
        .select(
          database.managerTable,
        )
        .get();

    List<clock.ManagerEmployeeDto> managers = [];
    for (ManagerTableData tableData in tableDatas) {
      managers.add((await loadComplementAndConvert(tableData))!);
    }

    return managers;
  }

  @override
  ManagerTableData convertToTable({
    required ManagerEmployee manager,
  }) {
    ManagerTableData tableData = ManagerTableData(
      id: manager.id!,
      mail: manager.mail,
      platformUserName: manager.platformUserName,
    );

    return tableData;
  }

  @override
  clock.ManagerEmployeeDto convertToDto({
    required ManagerTableData tableData,
  }) {
    clock.ManagerEmployeeDto managerEmployeeDto = clock.ManagerEmployeeDto(
      id: tableData.id,
      mail: tableData.mail,
      platformUserName: tableData.platformUserName,
    );

    return managerEmployeeDto;
  }

  @override
  Future<clock.ManagerEmployeeDto?> findByPlatformUserId({
    required String platformUserId,
  }) async {
    List<ManagersPlatformUsersTableData> managerPlatformUsers =
        await (database.select(database.managersPlatformUsersTable)
              ..where((tbl) => tbl.platforUsersId.equals(platformUserId)))
            .get();
    clock.ManagerEmployeeDto? managerEmployeeDto;
    for (ManagersPlatformUsersTableData managerPlatformUser
        in managerPlatformUsers) {
      var manager = await findById(id: managerPlatformUser.managerId);
      if (manager != null) {
        managerEmployeeDto = manager;
      }
    }
    return managerEmployeeDto;
  }
}
