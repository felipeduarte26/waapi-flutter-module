import '../../entities/overnight_entity.dart';

abstract class IOvernightRepository {
  Future<bool> exist({
    required String id,
  });

  Future<int> insert({
    required OvernightEntity overnightEntity,
  });

  Future<bool> update({
    required OvernightEntity overnightEntity,
  });

  Future<bool> save({
    required OvernightEntity overnightEntity,
  });

  Future<List<OvernightEntity>> getAll();

  Future<OvernightEntity?> findById({
    required String id,
  });

  Future<List<OvernightEntity>> findNotSynchronized();

  Future<List<OvernightEntity>> findByDateAndEmployee({
    required DateTime dateToCompare,
    required String employeeId,
  });

  Future<List<OvernightEntity>> findByEmployee({
    required String employeeId,
  });

  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  });
}
