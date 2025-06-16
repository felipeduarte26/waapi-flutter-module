import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../external/drift/collector_database.dart';
import '../../entities/manager_employee.dart';

abstract class IManagerRepository {
  Future<bool> exist({
    required String managerId,
  });

  Future<int> insert({
    required ManagerEmployee manager,
  });

  Future<bool> update({
    required ManagerEmployee manager,
  });

  Future<bool> save(
      {required ManagerEmployee managerDto,});

  ManagerTableData convertToTable({
    required ManagerEmployee manager,
  });

  Future<List<clock.ManagerEmployeeDto>> getAll();

  Future<clock.ManagerEmployeeDto?> findById({required String id});

  Future<clock.ManagerEmployeeDto?> findByMail({required String mail});

  Future<clock.ManagerEmployeeDto?> findByPlatformUserId(
      {required String platformUserId,});

  Future<void> deleteAll();

  clock.ManagerEmployeeDto convertToDto({
    required ManagerTableData tableData,
  });
}
