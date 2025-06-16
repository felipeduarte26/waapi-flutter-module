import '../types/profile_domain_types.dart';

abstract class GetAddressByPostalCodeRepository {
  GetAddressByPostalCodeUsecaseCallback call({
    required String postalCode,
  });
}
