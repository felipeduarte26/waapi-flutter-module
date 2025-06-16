import 'dart:convert';

import '../../infra/models/city_model.dart';

class NaturalitySearchModelMapper {
  CityModel fromMap({
    required Map<String, dynamic> naturalityMap,
  }) {
    return CityModel(
      id: naturalityMap['id'],
      name: naturalityMap['name'],
    );
  }

  List<CityModel> fromJsonList({
    required String naturalityJson,
  }) {
    if (naturalityJson.isEmpty) {
      return [];
    }

    final nationalitiesDecoded = jsonDecode(naturalityJson);

    return (nationalitiesDecoded as List).map(
      (naturalityMap) {
        return fromMap(
          naturalityMap: naturalityMap,
        );
      },
    ).toList();
  }
}
