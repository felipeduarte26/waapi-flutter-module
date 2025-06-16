import '../../domain/entities/country_entity.dart';
import '../../infra/models/country_model.dart';

class CountryEntityAdapter {
  CountryEntity fromModel({
    required CountryModel countryModel,
  }) {
    return CountryEntity(
      abbreviation: countryModel.abbreviation,
      name: countryModel.name,
      id: countryModel.id,
    );
  }
}
