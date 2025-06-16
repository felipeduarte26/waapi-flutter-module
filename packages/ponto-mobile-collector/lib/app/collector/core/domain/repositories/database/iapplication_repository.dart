import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../external/drift/collector_database.dart';


abstract class IApplicationRepository {
  Future<bool> exist({
    required String tenantName,
  });

  Future<int> insert({
    required clock.ApplicationDto application,
  });

  Future<bool> save({
    required clock.ApplicationDto application,
  });

  Future<bool> update({
    required clock.ApplicationDto application,
  });

  Future<clock.ApplicationDto?> findByTenantName({
    required String tenantName,
  });

  ApplicationTableData convertToTable({
    required clock.ApplicationDto application,
  });

  clock.ApplicationDto convertToDto({
    required ApplicationTableData tableData,
  });

  List<clock.ApplicationDto> convertToDtoList({
    required List<ApplicationTableData> datas,
  });

  Future<List<clock.ApplicationDto>> getAll();
}
