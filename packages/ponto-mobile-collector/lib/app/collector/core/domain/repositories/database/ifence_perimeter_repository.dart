
import '../../../external/drift/collector_database.dart';

abstract class IFencePerimeterRepository {
  Future<bool> exist({
    required String perimeterId,
    required String fenceId,
  });

  Future<int> insert({
    required String perimeterId,
    required String fenceId,
  });

  Future<bool> save({required String fenceId, required String perimeterId});

  Future<List<FencePerimeterTableData>> getAll();

  Future<List<String>> findAllByFenceId({required String fenceId});

  FencePerimeterTableData convertToTable({
    required String perimeterId,
    required String fenceId,
  });
}
