import '../models/address_model.dart';

abstract class GetAddressByPostalCodeDatasource {
  Future<AddressModel> call({
    required String postalCode,
  });
}
