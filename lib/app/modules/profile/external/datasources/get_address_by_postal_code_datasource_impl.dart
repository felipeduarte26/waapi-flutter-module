import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_address_by_postal_code_datasource.dart';
import '../../infra/models/address_model.dart';
import '../mappers/address_model_mapper.dart';

class GetAddressByPostalCodeDatasourceImpl implements GetAddressByPostalCodeDatasource {
  final RestService _restService;
  final AddressModelMapper _addressByPostalCodeModelMapper;

  const GetAddressByPostalCodeDatasourceImpl({
    required RestService restService,
    required AddressModelMapper addressByPostalCodeModelMapper,
  })  : _restService = restService,
        _addressByPostalCodeModelMapper = addressByPostalCodeModelMapper;

  @override
  Future<AddressModel> call({
    required String postalCode,
  }) async {
    final postalCodeResponse =
        await _restService.legacyManagementPanelService().get('https://viacep.com.br/ws/$postalCode/json/');

    return _addressByPostalCodeModelMapper.fromJson(
      addressJson: postalCodeResponse.data!,
    );
  }
}
