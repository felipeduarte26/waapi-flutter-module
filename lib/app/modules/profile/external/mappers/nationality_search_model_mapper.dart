import 'dart:convert';

import '../../infra/models/nationality_model.dart';

class NationalitySearchModelMapper {
  NationalityModel fromMap({
    required Map<String, dynamic> nationalityMap,
  }) {
    return NationalityModel(
      id: nationalityMap['id'],
      name: nationalityMap['name'],
    );
  }

  List<NationalityModel> fromJsonList({
    required String nationalityJson,
  }) {
    if (nationalityJson.isEmpty) {
      return [];
    }

    final nationalitiesDecoded = jsonDecode(nationalityJson);

    return (nationalitiesDecoded as List).map(
      (nationalityMap) {
        return fromMap(
          nationalityMap: nationalityMap,
        );
      },
    ).toList();
  }
}
