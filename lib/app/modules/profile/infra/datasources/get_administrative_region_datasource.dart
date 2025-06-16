import '../models/administrative_region_model.dart';

abstract class GetAdministrativeRegionDatasource {
  Future<List<AdministrativeRegionModel>> call({
    required String cityId,
  });
}
