import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../domain/repositories/database/imanager_platform_user_repository.dart';
import '../../../external/drift/collector_database.dart';
import 'platform_user_repository.dart';

class ManagerPlatformUserRepository implements IManagerPlatformUserRepository {
  CollectorDatabase database;
  PlatformUserRepository platformUserRepository;

  ManagerPlatformUserRepository({
    required this.database,
    required this.platformUserRepository,
  });

  @override
  Future<bool> exist({
    required String managerId,
  }) async {
    final query = database.select(database.managersPlatformUsersTable);
    query.where((tbl) => tbl.managerId.equals(managerId));
    ManagersPlatformUsersTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required String managerId,
    required String platformUserId,
  }) async {
    ManagersPlatformUsersTableData tableData =
        convertToTable(managerId: managerId, platforUserId: platformUserId);
    return database.into(database.managersPlatformUsersTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required String managerId,
    required String platformUserId,
  }) async {
    final ManagersPlatformUsersTableData updatedData =
        convertToTable(managerId: managerId, platforUserId: platformUserId);

    final affectedRows =
        await (database.update(database.managersPlatformUsersTable)
              ..where((tbl) => tbl.platforUsersId.equals(platformUserId))
              ..where((tbl) => tbl.managerId.equals(managerId)))
            .write(updatedData);

    return affectedRows > 0;
  }

  @override
  Future<bool> save({
    required String managerId,
    required String platformUserId,
  }) async {
    if (!await exist(managerId: managerId)) {
      await insert(managerId: managerId, platformUserId: platformUserId);
    } else {
      await update(managerId: managerId, platformUserId: platformUserId);
    }
    return true;
  }

  @override
  Future<List<clock.PlatformUserEmployeeDto>> findPlatformUsersByManager({
    required String managerId,
  }) async {
    List<ManagersPlatformUsersTableData> managerPlatformUsers =
        await (database.select(database.managersPlatformUsersTable)
              ..where((tbl) => tbl.managerId.equals(managerId)))
            .get();

    List<clock.PlatformUserEmployeeDto> platformUsers = [];
    for (ManagersPlatformUsersTableData managerPlatformUser
        in managerPlatformUsers) {
      clock.PlatformUserEmployeeDto? platformUserEmployeeDto =
          await platformUserRepository.findById(
        platformUserId: managerPlatformUser.platforUsersId,
      );
      if (platformUserEmployeeDto != null) {
        platformUsers.add(platformUserEmployeeDto);
      }
    }
    return platformUsers;
  }

  @override
  ManagersPlatformUsersTableData convertToTable({
    required String managerId,
    required String platforUserId,
  }) {
    ManagersPlatformUsersTableData tableData = ManagersPlatformUsersTableData(
      managerId: managerId,
      platforUsersId: platforUserId,
    );

    return tableData;
  }

  @override
  Future<void> deleteAll() async {
    await database.delete(database.managersPlatformUsersTable).go();
  }
}
