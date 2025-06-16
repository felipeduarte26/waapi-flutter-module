import '../repositories/get_administrative_region_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetAdministrativeRegionUsecase {
  GetAdministrativeRegionUsecaseCallback call({
    required String cityId,
  });
}

class GetAdministrativeRegionUsecaseImpl implements GetAdministrativeRegionUsecase {
  final GetAdministrativeRegionRepository _getAdministrativeRegionRepository;

  const GetAdministrativeRegionUsecaseImpl({
    required GetAdministrativeRegionRepository getAdministrativeRegionRepository,
  }) : _getAdministrativeRegionRepository = getAdministrativeRegionRepository;

  @override
  GetAdministrativeRegionUsecaseCallback call({
    required String cityId,
  }) {
    return _getAdministrativeRegionRepository.call(
      cityId: cityId,
    );
  }
}
