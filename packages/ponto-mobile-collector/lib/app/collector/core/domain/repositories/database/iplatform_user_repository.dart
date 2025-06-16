import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../external/drift/collector_database.dart';
import '../../entities/platform_user.dart';

abstract class IPlatformUserRepository {
  Future<bool> exist({
    required String platformUserId,
  });

  Future<int> insert({
    required PlatformUser platformUser,
  });

  Future<bool> update({
    required PlatformUser platformUser,
  });

  Future<bool> save({
    required PlatformUser platformUser,
  });

  Future<bool> saveAll({
    required List<PlatformUser> platformUsers,
  });

  Future<List<clock.PlatformUserEmployeeDto>> getAll();

  Future<clock.PlatformUserEmployeeDto?> findById({
    required String platformUserId,
  });

  Future<PlatformUser?> findByUserName({
    required String username,
  });

  Future<void> deleteAll();

  PlatformUser? convertToEntity({required PlatformUsersTableData platformUser});

  PlatformUsersTableData convertToTable({
    required PlatformUser platformUser,
  });
}
