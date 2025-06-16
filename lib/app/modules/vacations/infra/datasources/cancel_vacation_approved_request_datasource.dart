import '../../../../core/types/either.dart';

abstract class CancelVacationApprovedRequestDatasource {
  Future<Either<List<String>, Unit>> call({
    required String vacationSheduleToCancelId,
    required String employeeId,
  });
}
