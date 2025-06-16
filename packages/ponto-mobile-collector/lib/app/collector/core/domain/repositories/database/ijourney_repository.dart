import '../../entities/journey_entity.dart';

abstract class IJourneyRepository {
  Future<bool> exist({
    required String id,
  });

  Future<int> insert({
    required JourneyEntity journeyEntity,
  });

  Future<bool> update({
    required JourneyEntity journeyEntity,
  });

  Future<bool> save({
    required JourneyEntity journeyEntity,
  });

  Future<List<JourneyEntity>> getAll();

  Future<JourneyEntity?> findById({
    required String id,
  });

  Future<JourneyEntity?> findByJourneyNumber({
    required int journeyNumber,
  });

  Future<JourneyEntity?> findCurrentJourneyByEmployeeId({
    required String employeeId,
  });

  Future<List<JourneyEntity>> findByDate({
    required DateTime date,
    required String employeeId,
  });

  Future<int> delete({required String id});

  Future<JourneyEntity?> findLastJourney();

  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  });
}
