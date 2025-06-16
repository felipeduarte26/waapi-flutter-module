import '../../entities/activation.dart';

abstract class IActivationRepository {
  Future<bool> exist({
    required String employeeId,
  });

  Future<int> insert({
    required Activation activation,
    required String employeeId,
  });

  Future<bool> update({
    required Activation activation,
    required String employeeId,
  });

  Future<bool> save({
    required Activation activation,
    required String employeeId,
  });

  Future<List<Activation>> getAll();

  Future<Activation?> findByEmployeeId({required String employeeId});

  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  });
}
