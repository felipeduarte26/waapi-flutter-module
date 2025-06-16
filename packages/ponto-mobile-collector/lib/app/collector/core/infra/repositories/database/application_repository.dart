import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';
import '../../../external/drift/collector_database.dart';


class ApplicationRepository implements IApplicationRepository {
  CollectorDatabase database;

  ApplicationRepository({required this.database});

  @override
  clock.ApplicationDto convertToDto({
    required ApplicationTableData tableData,
  }) {
    return clock.ApplicationDto(
      tenantName: tableData.tenantName,
      accessKey: tableData.accessKey,
      secret: tableData.secret,
      lastUpdate: tableData.lastUpdate,
    );
  }

  @override
  ApplicationTableData convertToTable({
    required clock.ApplicationDto application,
  }) {
    return ApplicationTableData(
      tenantName: application.tenantName,
      accessKey: application.accessKey,
      secret: application.secret,
      lastUpdate: application.lastUpdate,
    );
  }

  @override
  List<clock.ApplicationDto> convertToDtoList({
    required List<ApplicationTableData> datas,
  }) {
    List<clock.ApplicationDto> dtoList = [];

    if (datas.isNotEmpty) {
      for (ApplicationTableData tableData in datas) {
        clock.ApplicationDto dto = convertToDto(tableData: tableData);
        dtoList.add(dto);
      }
    }

    return dtoList;
  }

  @override
  Future<bool> exist({required String tenantName}) async {
    final query = database.select(database.applicationTable);
    query.where((tbl) => tbl.tenantName.equals(tenantName));
    ApplicationTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<clock.ApplicationDto?> findByTenantName({
    required String tenantName,
  }) async {
    final query = database.select(database.applicationTable);
    query.where((tbl) => tbl.tenantName.equals(tenantName));
    ApplicationTableData? tableData = await query.getSingleOrNull();

    if (tableData == null) {
      return null;
    } else {
      return convertToDto(tableData: tableData);
    }
  }

  @override
  Future<int> insert({required clock.ApplicationDto application}) async {
    ApplicationTableData tableData = convertToTable(application: application);
    return database.into(database.applicationTable).insert(tableData);
  }

  @override
  Future<bool> save({required clock.ApplicationDto application}) async {
    return (await exist(tenantName: application.tenantName))
        ? await update(application: application)
        : (await insert(application: application)) > 0;
  }

  @override
  Future<bool> update({required clock.ApplicationDto application}) async {
    ApplicationTableData tableData = convertToTable(application: application);
    return database.update(database.applicationTable).replace(tableData);
  }

  @override
  Future<List<clock.ApplicationDto>> getAll() async {
    List<ApplicationTableData> datas =
        await database.select(database.applicationTable).get();
    return convertToDtoList(datas: datas);
  }
}
