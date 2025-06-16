import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/input_models/dependent_dto_input_model.dart';
import '../../domain/repositories/update_dependents_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/update_dependents_datasource.dart';

class UpdateDependentsRepositoryImpl implements UpdateDependentsRepository {
  final UpdateDependentsDatasource _updateDependentsDatasource;

  const UpdateDependentsRepositoryImpl({
    required UpdateDependentsDatasource updateDependentsDatasource,
  }) : _updateDependentsDatasource = updateDependentsDatasource;

  @override
  UpdateDependentsUsecaseCallback call({
    required DependentDtoInputModel dependentDtoInputModel,
  }) async {
    try {
      await _updateDependentsDatasource.call(
        dependentDtoInputModel: dependentDtoInputModel,
      );
      return right(unit);
    } catch (error) {
      return left(
        const UpdateDependentsDatasourceFailure(),
      );
    }
  }
}
