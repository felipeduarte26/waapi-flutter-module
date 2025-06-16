import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_address_by_postal_code_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/address_entity_adapter.dart';
import '../datasources/get_address_by_postal_code_datasource.dart';

class GetAddressByPostalCodeRepositoryImpl implements GetAddressByPostalCodeRepository {
  final GetAddressByPostalCodeDatasource _getAddressByPostalCodeDatasource;
  final AddressEntityAdapter _addressByPostalCodeEntityAdapter;

  GetAddressByPostalCodeRepositoryImpl({
    required GetAddressByPostalCodeDatasource getAddressByPostalCodeDatasource,
    required AddressEntityAdapter addressByPostalCodeEntityAdapter,
  })  : _getAddressByPostalCodeDatasource = getAddressByPostalCodeDatasource,
        _addressByPostalCodeEntityAdapter = addressByPostalCodeEntityAdapter;

  @override
  GetAddressByPostalCodeUsecaseCallback call({
    required String postalCode,
  }) async {
    try {
      final addressByPostalCodeModel = await _getAddressByPostalCodeDatasource.call(
        postalCode: postalCode,
      );

      final addressByPostalCodeEntity = _addressByPostalCodeEntityAdapter.fromModel(
        addressModel: addressByPostalCodeModel,
      );

      return right(addressByPostalCodeEntity);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
