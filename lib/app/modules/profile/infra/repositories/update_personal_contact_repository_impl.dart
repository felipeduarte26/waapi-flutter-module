import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/input_models/edit_personal_contact_input_model.dart';
import '../../domain/repositories/update_personal_contact_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/update_personal_contact_datasource.dart';

class UpdatePersonalContactRepositoryImpl implements UpdatePersonalContactRepository {
  final UpdatePersonalContactDatasource _updatePersonalContactDatasource;

  const UpdatePersonalContactRepositoryImpl({
    required UpdatePersonalContactDatasource updatePersonalContactDatasource,
  }) : _updatePersonalContactDatasource = updatePersonalContactDatasource;

  @override
  UpdatePersonalContactUsecaseCallback call({
    required EditPersonalContactInputModel editPersonalContactInputModel,
  }) async {
    try {
      await _updatePersonalContactDatasource.call(
        editPersonalContactInputModel: editPersonalContactInputModel,
      );
      return right(unit);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
