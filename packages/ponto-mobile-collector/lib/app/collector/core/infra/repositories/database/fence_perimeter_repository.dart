

import '../../../../../../ponto_mobile_collector.dart';
import '../../../external/drift/collector_database.dart';

class FencePerimeterRepository implements IFencePerimeterRepository {
  CollectorDatabase database;

  FencePerimeterRepository({required this.database});

  @override
  Future<bool> exist({
    required String perimeterId,
    required String fenceId,
  }) async {
    final query = database.select(database.fencePerimeterTable);
    query.where((tbl) => tbl.perimeterId.equals(perimeterId));
    query.where((tbl) => tbl.fenceId.equals(fenceId));
    FencePerimeterTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required String perimeterId,
    required String fenceId,
  }) async {
    FencePerimeterTableData tableData = convertToTable(
      perimeterId: perimeterId,
      fenceId: fenceId,
    );

    return database.into(database.fencePerimeterTable).insert(tableData);
  }

  @override
  Future<bool> save({
    required String fenceId,
    required String perimeterId,
  }) async {
    return (await exist(perimeterId: perimeterId, fenceId: fenceId))
        ? true
        : (await insert(fenceId: fenceId, perimeterId: perimeterId)) > 0;
  }

  @override
  Future<List<FencePerimeterTableData>> getAll() async {
    return database.select(database.fencePerimeterTable).get();
  }

  @override
  Future<List<String>> findAllByFenceId({required String fenceId}) async {
    final query = database.select(database.fencePerimeterTable);
    query.where((tbl) => tbl.fenceId.equals(fenceId));

    List<FencePerimeterTableData> datas = await query.get();

    List<String> perimetersId = [];
    for (FencePerimeterTableData tableData in datas) {
      perimetersId.add(tableData.perimeterId);
    }

    return perimetersId;
  }

  @override
  FencePerimeterTableData convertToTable({
    required String perimeterId,
    required String fenceId,
  }) {
    return FencePerimeterTableData(
      fenceId: fenceId,
      perimeterId: perimeterId,
    );
  }
}
