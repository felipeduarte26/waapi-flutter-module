import 'dart:convert';
import 'dart:developer';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:drift/drift.dart';

import '../../../domain/entities/overnight_entity.dart';
import '../../../domain/repositories/database/iovernight_repository.dart';
import '../../../external/drift/collector_database.dart';

class OvernightRepository implements IOvernightRepository {
  CollectorDatabase database;

  OvernightRepository({required this.database});

  @override
  Future<bool> exist({
    required String id,
  }) async {
    final query = database.select(database.overnightTable);
    query.where((tbl) => tbl.id.equals(id));
    OvernightTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required OvernightEntity overnightEntity,
  }) async {
    OvernightTableData tableData = convertToTable(
      overnightEntity: overnightEntity,
    );
    return database.into(database.overnightTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required OvernightEntity overnightEntity,
  }) async {
    OvernightTableData tableData = convertToTable(
      overnightEntity: overnightEntity,
    );
    return database.update(database.overnightTable).replace(tableData);
  }

  @override
  Future<bool> save({
    required OvernightEntity overnightEntity,
  }) async {
    return (await exist(id: overnightEntity.id))
        ? await update(overnightEntity: overnightEntity)
        : (await insert(overnightEntity: overnightEntity)) > 0;
  }

  @override
  Future<List<OvernightEntity>> getAll() async {
    List<OvernightTableData> tableDatas =
        await database.select(database.overnightTable).get();
    List<OvernightEntity> activations = [];

    for (OvernightTableData tableData in tableDatas) {
      var overnightEntity = await convertToDto(tableData: tableData);
      activations.add(overnightEntity);
    }

    return activations;
  }

  @override
  Future<OvernightEntity?> findById({
    required String id,
  }) async {
    final query = database.select(database.overnightTable)
      ..where((tbl) => tbl.id.equals(id));

    OvernightTableData? tableData = await query.getSingleOrNull();

    if (tableData == null) {
      return null;
    }

    return convertToDto(tableData: tableData);
  }

  @override
  Future<List<OvernightEntity>> findNotSynchronized() async {
    final query = database.select(database.overnightTable)
      ..where((tbl) => tbl.synchronized.equals(false));

    List<OvernightTableData> entities = await query.get();

    List<OvernightEntity> overnights = [];
    for (OvernightTableData tableData in entities) {
      var overnightEntity = await convertToDto(tableData: tableData);
      overnights.add(overnightEntity);
    }

    return overnights;
  }

  OvernightTableData convertToTable({
    required OvernightEntity overnightEntity,
  }) {
    OvernightTableData overnightData = OvernightTableData(
      id: overnightEntity.id,
      date: overnightEntity.date,
      synchronized: overnightEntity.synchronized ?? false,
      geolocation: overnightEntity.geolocation != null
          ? jsonEncode(overnightEntity.geolocation)
          : null,
      locationStatus: overnightEntity.locationStatus.id,
      type: overnightEntity.type,
      employee: overnightEntity.employee.id,
    );

    return overnightData;
  }

  Future<OvernightEntity> convertToDto({
    required OvernightTableData tableData,
  }) async {
    final query = database.select(database.overnightTable).join(
      [
        innerJoin(
          database.employeeTable,
          database.employeeTable.id.equalsExp(database.overnightTable.employee),
        ),
      ],
    )..where(database.overnightTable.id.equals(tableData.id));

    var result = await query.getSingleOrNull();

    clock.EmployeeDto? employeeDto;
    if (result != null) {
      var employeeTableData = result.readTable(database.employeeTable);
      employeeDto = clock.EmployeeDto(
        id: employeeTableData.id,
        name: employeeTableData.name,
        pis: employeeTableData.pis,
        cpf: employeeTableData.cpfNumber,
        employeeType: employeeTableData.employeeType,
        arpId: employeeTableData.arpId,
        employeeCode: employeeTableData.employeeCode,
        enable: employeeTableData.enable,
        faceRegistered: employeeTableData.faceRegistered,
        mail: employeeTableData.mail,
        nfcCode: employeeTableData.nfcCode,
        registrationNumber: employeeTableData.registrationNumber,
      );
    } else {
      throw Exception('Employee not found on overnight');
    }

    var overnightEntity = OvernightEntity(
      id: tableData.id,
      date: tableData.date.toUtc(),
      synchronized: tableData.synchronized,
      locationStatus: LocationStatusEnum.build(tableData.locationStatus),
      type: tableData.type,
      employee: employeeDto,
    );

    if (tableData.geolocation != null) {
      var decode = jsonDecode(tableData.geolocation!);
      clock.LocationDTO locationDto = clock.LocationDTO(
        latitude: decode['latitude'],
        longitude: decode['longitude'],
        dateAndTime: DateTime.parse(decode['dateAndTime']),
      );
      overnightEntity = overnightEntity.copyWith(
        synchronized: false,
        geolocation: locationDto,
      );
    }

    return overnightEntity;
  }

  @override
  Future<List<OvernightEntity>> findByDateAndEmployee({
    required DateTime dateToCompare,
    required String employeeId,
  }) async {
    log(dateToCompare.toIso8601String());
    final query = database.select(database.overnightTable)
      ..where(
        (tbl) =>
            tbl.employee.equals(employeeId) &
            tbl.date.day.equals(dateToCompare.day) &
            tbl.date.month.equals(dateToCompare.month) &
            tbl.date.year.equals(dateToCompare.year),
      );

    List<OvernightTableData> entities = await query.get();

    List<OvernightEntity> overnights = [];
    for (OvernightTableData tableData in entities) {
      var overnightEntity = await convertToDto(tableData: tableData);
      overnights.add(overnightEntity);
    }

    return overnights;
  }

  @override
  Future<List<OvernightEntity>> findByEmployee({
    required String employeeId,
  }) async {
    final query = database.select(database.overnightTable)
      ..where((tbl) => tbl.employee.equals(employeeId));

    List<OvernightTableData> entities = await query.get();

    List<OvernightEntity> overnights = [];
    for (OvernightTableData tableData in entities) {
      var overnightEntity = await convertToDto(tableData: tableData);
      overnights.add(overnightEntity);
    }

    return overnights;
  }

  @override
  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.overnightTable);
    query.where(
      (overnight) => existsQuery(
        database.select(database.journeyTable)
          ..where(
            (journey) => journey.employeeId.isIn(employeeIds),
          )
          ..where(
            (journey) => journey.overnightId.equalsExp(overnight.id),
          ),
      ),
    );

    await query.go();
  }
}
