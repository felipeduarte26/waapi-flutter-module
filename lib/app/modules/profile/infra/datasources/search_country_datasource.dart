import '../models/country_model.dart';

abstract class SearchCountryDatasource {
  Future<List<CountryModel>> call({
    required String country,
  });
}
