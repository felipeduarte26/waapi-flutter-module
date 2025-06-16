import 'package:drift/drift.dart';

import '../../../domain/entities/journey_entity.dart';
import '../../../domain/repositories/database/ijourney_repository.dart';
import '../../../external/drift/collector_database.dart';

class JourneyRepository implements IJourneyRepository {
  CollectorDatabase database;

  JourneyRepository({required this.database});

  @override
  Future<bool> exist({
    required String id,
  }) async {
    final query = database.select(database.journeyTable);
    query.where((tbl) => tbl.id.equals(id));
    JourneyTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required JourneyEntity journeyEntity,
  }) async {
    final journeyEntityFormatted = await _addNewJourneyNumber(journeyEntity);

    JourneyTableData tableData = convertToTable(
      journeyEntity: journeyEntityFormatted,
    );

    return database.into(database.journeyTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required JourneyEntity journeyEntity,
  }) async {
    JourneyTableData tableData = convertToTable(
      journeyEntity: journeyEntity,
    );
    return database.update(database.journeyTable).replace(tableData);
  }

  @override
  Future<bool> save({
    required JourneyEntity journeyEntity,
  }) async {
    return (await exist(id: journeyEntity.id))
        ? await update(journeyEntity: journeyEntity)
        : (await insert(journeyEntity: journeyEntity)) > 0;
  }

  @override
  Future<List<JourneyEntity>> getAll() async {
    List<JourneyTableData> tableDatas =
        await database.select(database.journeyTable).get();
    List<JourneyEntity> activations = [];

    for (JourneyTableData tableData in tableDatas) {
      activations.add(convertToDto(tableData: tableData));
    }

    return activations;
  }

  @override
  Future<JourneyEntity?> findById({
    required String id,
  }) async {
    JourneyTableData? tableData = await (database.select(database.journeyTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (tableData == null) {
      return null;
    }

    return convertToDto(tableData: tableData);
  }

  @override
  Future<JourneyEntity?> findByJourneyNumber({
    required int journeyNumber,
  }) async {
    JourneyTableData? tableData = await (database.select(database.journeyTable)
          ..where((tbl) => tbl.journeyNumber.equals(journeyNumber)))
        .getSingleOrNull();

    if (tableData == null) {
      return null;
    } else {
      return convertToDto(tableData: tableData);
    }
  }

  @override
  Future<JourneyEntity?> findCurrentJourneyByEmployeeId({
    required String employeeId,
  }) async {
    final query = database.select(database.journeyTable)
      ..where((tbl) => tbl.employeeId.equals(employeeId))
      ..where((tbl) => tbl.endDate.isNull())
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.journeyNumber)])
      ..limit(1);

    JourneyTableData? tableData = await query.getSingleOrNull();

    if (tableData == null) {
      return null;
    } else {
      return convertToDto(tableData: tableData);
    }
  }

  @override
  Future<int> delete({required String id}) async {
    var delete = database.delete(database.journeyTable);
    delete.where((tbl) => tbl.id.equals(id));
    return await delete.go();
  }

  @override
  Future<List<JourneyEntity>> findByDate({
    required DateTime date,
    required String employeeId,
  }) async {
    final query = database.select(database.journeyTable);
    query.where(
      (tbl) =>
          tbl.startDate.year.equals(date.year) &
          tbl.startDate.month.equals(date.month) &
          tbl.startDate.day.equals(date.day),
    );
    query.where((tbl) => tbl.employeeId.isValue(employeeId));
    List<JourneyTableData> tableDatas = await query.get();

    var journeys = <JourneyEntity>[];
    for (JourneyTableData data in tableDatas) {
      journeys.add(convertToDto(tableData: data));
    }

    return journeys;
  }

  Future<JourneyEntity> _addNewJourneyNumber(
    JourneyEntity journeyEntity,
  ) async {
    final query = database.select(database.journeyTable)
      ..where((tbl) => tbl.employeeId.equals(journeyEntity.employeeId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.journeyNumber)])
      ..limit(1);

    final lastJourney = await query.getSingleOrNull();

    return journeyEntity.copyWith(
      journeyNumber: lastJourney?.journeyNumber ?? 0 + 1,
    );
  }

  JourneyTableData convertToTable({
    required JourneyEntity journeyEntity,
  }) {
    JourneyTableData activationData = JourneyTableData(
      id: journeyEntity.id,
      journeyNumber: journeyEntity.journeyNumber,
      overnightId: journeyEntity.overnightId,
      startDate: journeyEntity.startDate,
      endDate: journeyEntity.endDate,
      employeeId: journeyEntity.employeeId,
    );

    return activationData;
  }

  JourneyEntity convertToDto({
    required JourneyTableData tableData,
  }) {
    return JourneyEntity(
      id: tableData.id,
      employeeId: tableData.employeeId,
      journeyNumber: tableData.journeyNumber,
      startDate: tableData.startDate.toUtc(),
      endDate: tableData.endDate?.toUtc(),
      overnightId: tableData.overnightId,
    );
  }

  @override
  Future<JourneyEntity?> findLastJourney() async {
    final query = database.select(database.journeyTable)
      ..orderBy([
        (tbl) => OrderingTerm.desc(tbl.endDate),
      ])
      ..limit(1);

    final tableData = await query.getSingleOrNull();

    if (tableData == null) {
      return null;
    } else {
      return convertToDto(tableData: tableData);
    }
  }

  @override
  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.journeyTable);
    query.where((tbl) => tbl.employeeId.isIn(employeeIds));

    await query.go();
  }
}
