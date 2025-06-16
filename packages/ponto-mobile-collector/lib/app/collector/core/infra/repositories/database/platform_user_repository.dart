import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../domain/entities/platform_user.dart';
import '../../../domain/repositories/database/iplatform_user_repository.dart';
import '../../../external/drift/collector_database.dart';

class PlatformUserRepository implements IPlatformUserRepository {
  CollectorDatabase database;

  PlatformUserRepository({
    required this.database,
  });

  @override
  Future<bool> exist({
    required String platformUserId,
  }) async {
    final query = database.select(database.platformUsersTable);
    query.where((tbl) => tbl.id.equals(platformUserId));
    PlatformUsersTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required PlatformUser platformUser,
  }) async {
    PlatformUsersTableData tableData =
        convertToTable(platformUser: platformUser);
    return database.into(database.platformUsersTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required PlatformUser platformUser,
  }) async {
    PlatformUsersTableData tableData =
        convertToTable(platformUser: platformUser);
    return database.update(database.platformUsersTable).replace(tableData);
  }

  @override
  Future<bool> save({
    required PlatformUser platformUser,
  }) async {
    if (await exist(platformUserId: platformUser.id!)) {
      await update(platformUser: platformUser);
    } else {
      await insert(platformUser: platformUser);
    }

    return true;
  }

  @override
  Future<bool> saveAll({
    required List<PlatformUser> platformUsers,
  }) async {
    if (platformUsers.isNotEmpty) {
      for (PlatformUser platformUser in platformUsers) {
        await save(platformUser: platformUser);
      }
    }

    return true;
  }

  @override
  Future<List<clock.PlatformUserEmployeeDto>> getAll() async {
    List<PlatformUsersTableData> platformUsersTable =
        await database.select(database.platformUsersTable).get();
    List<clock.PlatformUserEmployeeDto> platformUsers = [];

    for (PlatformUsersTableData platformUserTable in platformUsersTable) {
      clock.PlatformUserEmployeeDto platformUserEmployeeDto =
          converToDto(platformUser: platformUserTable);

      platformUsers.add(platformUserEmployeeDto);
    }

    return platformUsers;
  }

  @override
  Future<clock.PlatformUserEmployeeDto?> findById({
    required String platformUserId,
  }) async {
    PlatformUsersTableData? platformUsersTable =
        await (database.select(database.platformUsersTable)
              ..where((tbl) => tbl.id.equals(platformUserId)))
            .getSingleOrNull();
    clock.PlatformUserEmployeeDto platformUsers =
        converToDto(platformUser: platformUsersTable!);

    return platformUsers;
  }

  @override
  Future<PlatformUser?> findByUserName({
    required String username,
  }) async {
    var platformUsersTable = (database.select(database.platformUsersTable)
      ..where((tbl) => tbl.name.equals(username))
      ..limit(1));

    var platformUserByName = await platformUsersTable.getSingleOrNull();

    PlatformUser? platformUser;
    if (platformUserByName != null) {
      platformUser = convertToEntity(platformUser: platformUserByName);
    }

    return platformUser;
  }

  @override
  Future<void> deleteAll() async {
    await database.delete(database.platformUsersTable).go();
  }

  @override
  PlatformUsersTableData convertToTable({
    required PlatformUser platformUser,
  }) {
    PlatformUsersTableData tableData = PlatformUsersTableData(
      id: platformUser.id!,
      name: platformUser.platformUserName!,
    );

    return tableData;
  }

  clock.PlatformUserEmployeeDto converToDto({
    required PlatformUsersTableData platformUser,
  }) {
    clock.PlatformUserEmployeeDto platformUserEmployeeDto =
        clock.PlatformUserEmployeeDto(
      id: platformUser.id,
      username: platformUser.name,
    );

    return platformUserEmployeeDto;
  }
  
  @override
  PlatformUser? convertToEntity({required PlatformUsersTableData platformUser}) {
    return PlatformUser(
      id: platformUser.id,
      platformUserName: platformUser.name,
    );
  }
}
