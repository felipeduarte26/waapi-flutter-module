import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_dependents_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/dependent_entity_adapter.dart';
import '../datasources/get_dependents_datasource.dart';

class GetDependentsRepositoryImpl implements GetDependentsRepository {
  final GetDependentsDatasource _getDependentsDatasource;
  final DependentEntityAdapter _dependentEntityAdapter;

  const GetDependentsRepositoryImpl({
    required GetDependentsDatasource getDependentsDatasource,
    required DependentEntityAdapter dependentEntityAdapter,
  })  : _getDependentsDatasource = getDependentsDatasource,
        _dependentEntityAdapter = dependentEntityAdapter;

  @override
  GetDependentsUsecaseCallback call({
    required String employeeId,
  }) async {
    try {
      final dependentsModel = await _getDependentsDatasource.call(
        employeeId: employeeId,
      );

      final dependentsEntity = dependentsModel.map(
        (dependentModel) {
          return _dependentEntityAdapter.fromModel(
            dependentModel: dependentModel,
          );
        },
      ).toList();

      return right(dependentsEntity);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
