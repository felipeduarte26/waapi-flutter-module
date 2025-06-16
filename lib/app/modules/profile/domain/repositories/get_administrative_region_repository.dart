import '../types/profile_domain_types.dart';

abstract class GetAdministrativeRegionRepository {
  GetAdministrativeRegionUsecaseCallback call({
    required String cityId,
  });
}
