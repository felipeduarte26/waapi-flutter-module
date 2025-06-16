import '../../../../core/types/either.dart';
import '../../domain/failures/vacations_failure.dart';
import '../../domain/repositories/get_vacations_repository.dart';
import '../../domain/types/vacations_domain_types.dart';
import '../adapters/vacations_entity_adapter.dart';
import '../datasources/get_vacations_datasource.dart';

class GetVacationsRepositoryImpl implements GetVacationsRepository {
  final GetVacationsDatasource _getVacationsDatasource;

  const GetVacationsRepositoryImpl({
    required GetVacationsDatasource getVacationsDatasource,
  }) : _getVacationsDatasource = getVacationsDatasource;

  @override
  GetVacationsUsecaseCallback call({
    required String employeeId,
  }) async {
    try {
      final vacationModels = await _getVacationsDatasource.call(
        employeeId: employeeId,
      );

      final vacationEntities = vacationModels.map(
        (vacationModel) {
          return VacationsEntityAdapter.fromModel(
            vacationsModel: vacationModel,
          );
        },
      ).toList();

      return right(vacationEntities);
    } catch (error) {
      return left(const VacationsDatasourceFailure());
    }
  }
}
