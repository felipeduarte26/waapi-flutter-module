import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/input_models/edit_personal_data_input_model.dart';
import '../../domain/repositories/update_personal_data_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/update_personal_data_datasource.dart';

class UpdatePersonalDataRepositoryImpl implements UpdatePersonalDataRepository {
  final UpdatePersonalDataDatasource _updatePersonalDataDatasource;

  const UpdatePersonalDataRepositoryImpl({
    required UpdatePersonalDataDatasource updatePersonalDataDatasource,
  }) : _updatePersonalDataDatasource = updatePersonalDataDatasource;

  @override
  UpdatePersonalDataUsecaseCallback call({
    required EditPersonalDataInputModel editPersonalDataInputModel,
  }) async {
    try {
      await _updatePersonalDataDatasource.call(
        editPersonalDataInputModel: editPersonalDataInputModel,
      );
      return right(unit);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
