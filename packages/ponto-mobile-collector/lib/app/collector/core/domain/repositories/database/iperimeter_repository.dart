import '../../../external/drift/collector_database.dart';
import '../../entities/perimeter.dart';
abstract class IPerimeterRepository {
  Future<bool> exist({
    required String id,
  });

  Future<int> insert({
    required Perimeter perimeter,
  });

  Future<bool> update({
    required Perimeter perimeter,
  });

  Future<bool> saveAll({required List<Perimeter> perimeters});

  Future<bool> save({
    required Perimeter perimeter,
  });

  Future<List<Perimeter>> getAll();

  Future<List<Perimeter>> findAllByFenceId({
    required String fenceId,
  });

  Perimeter converToPerimeter({
    required PerimeterTableData perimeter,
  });

  List<Perimeter> convertToPerimeterList({
    required List<PerimeterTableData>? tableData,
  });

  PerimeterTableData convertToTable({
    required Perimeter perimeter,
  });
}
