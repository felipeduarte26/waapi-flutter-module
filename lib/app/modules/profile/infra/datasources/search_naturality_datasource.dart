import '../models/city_model.dart';

abstract class SearchNaturalityDatasource {
  Future<List<CityModel>> call({
    required String naturality,
  });
}
