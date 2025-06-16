import '../repositories/get_address_by_postal_code_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetAddressByPostalCodeUsecase {
  GetAddressByPostalCodeUsecaseCallback call({
    required String postalCode,
  });
}

class GetAddressByPostalCodeUsecaseImpl implements GetAddressByPostalCodeUsecase {
  final GetAddressByPostalCodeRepository _getAddressByPostalCodeRepository;

  const GetAddressByPostalCodeUsecaseImpl({
    required GetAddressByPostalCodeRepository getAddressByPostalCodeRepository,
  }) : _getAddressByPostalCodeRepository = getAddressByPostalCodeRepository;

  @override
  GetAddressByPostalCodeUsecaseCallback call({
    required String postalCode,
  }) {
    return _getAddressByPostalCodeRepository.call(
      postalCode: postalCode,
    );
  }
}
