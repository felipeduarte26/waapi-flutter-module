import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../external/drift/collector_database.dart';

abstract class IManagerPlatformUserRepository {
  Future<bool> exist({
    required String managerId,
  });

  Future<int> insert({
    required String managerId,
    required String platformUserId,
  });

  Future<bool> save({
    required String managerId,
    required String platformUserId,
  });

  Future<bool> update({
    required String managerId,
    required String platformUserId,
  });

  Future<List<clock.PlatformUserEmployeeDto>> findPlatformUsersByManager({
    required String managerId,
  });

  Future<void> deleteAll();

  ManagersPlatformUsersTableData convertToTable({
    required String managerId,
    required String platforUserId,
  });
}
