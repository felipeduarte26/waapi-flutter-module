import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/input_models/edit_personal_diversity_input_model.dart';
import '../../domain/repositories/update_personal_diversity_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/update_personal_diversity_datasource.dart';

class UpdatePersonalDiversityRepositoryImpl implements UpdatePersonalDiversityRepository {
  final UpdatePersonalDiversityDatasource _updatePersonalDiversityDatasource;

  const UpdatePersonalDiversityRepositoryImpl({
    required UpdatePersonalDiversityDatasource updatePersonalDiversityDatasource,
  }) : _updatePersonalDiversityDatasource = updatePersonalDiversityDatasource;

  @override
  UpdatePersonalDiversityUsecaseCallback call({
    required EditPersonalDiversityInputModel editPersonalDiversityInputModel,
  }) async {
    try {
      await _updatePersonalDiversityDatasource.call(
        editPersonalDiversityInputModel: editPersonalDiversityInputModel,
      );
      return right(unit);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
