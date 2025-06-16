import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/input_models/edit_personal_address_input_model.dart';
import '../../domain/repositories/update_personal_address_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/update_personal_address_datasource.dart';

class UpdatePersonalAddressRepositoryImpl implements UpdatePersonalAddressRepository {
  final UpdatePersonalAddressDatasource _updatePersonalAddressDatasource;

  const UpdatePersonalAddressRepositoryImpl({
    required UpdatePersonalAddressDatasource updatePersonalAddressDatasource,
  }) : _updatePersonalAddressDatasource = updatePersonalAddressDatasource;

  @override
  UpdatePersonalAddressUsecaseCallback call({
    required EditPersonalAddressInputModel editPersonalAddressInputModel,
  }) async {
    try {
      await _updatePersonalAddressDatasource.call(
        editPersonalAddressInputModel: editPersonalAddressInputModel,
      );
      return right(unit);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
