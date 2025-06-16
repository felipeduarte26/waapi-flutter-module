import '../../../../core/types/either.dart';

abstract class CancelVacationRequestDatasource {
  Future<Either<List<String>, Unit>> call({
    required String idVacation,
  });
}
