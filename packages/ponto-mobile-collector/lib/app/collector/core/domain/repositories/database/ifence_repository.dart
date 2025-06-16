import '../../../external/drift/collector_database.dart';
import '../../entities/fence.dart';

abstract class IFenceRepository {
  Future<bool> exist({
    required String id,
  });

  Future<int> insert({
    required Fence fence,
  });

  Future<bool> update({
    required Fence fence,
  });

  Future<bool> save({
    required Fence fence,
  });

  Future<bool> saveAll({
    required List<Fence> fences,
  });
  
  Future<List<Fence>> getAll();

  Future<List<Fence>> findAllByEmployeeId({
    required String employeeId,
  });

  FenceTableData convertToTable({
    required Fence fence,
  });
}
