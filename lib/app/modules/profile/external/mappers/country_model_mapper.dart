import 'dart:convert';

import '../../infra/models/country_model.dart';

class CountryModelMapper {
  CountryModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return CountryModel(
      id: map['id'],
      name: map['name'],
      abbreviation: map['abbreviation'],
    );
  }

  List<CountryModel> fromJsonList({
    required String countryJson,
  }) {
    if (countryJson.isEmpty) {
      return [];
    }

    final countriesDecoded = jsonDecode(countryJson);

    return (countriesDecoded as List).map(
      (countryMap) {
        return fromMap(
          map: countryMap,
        );
      },
    ).toList();
  }
}
