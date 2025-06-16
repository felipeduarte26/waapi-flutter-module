import 'dart:convert';

import '../../infra/models/education_degree_model.dart';

class EducationDegreeModelMapper {
  EducationDegreeModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return EducationDegreeModel(
      id: map['id'],
      name: map['name'],
      code: map['code'],
      type: map['educationDegreeType'],
    );
  }

  List<EducationDegreeModel> fromJsonList({
    required String educationDegreeJson,
  }) {
    if (educationDegreeJson.isEmpty) {
      return [];
    }

    final disabilitiesDecoded = jsonDecode(educationDegreeJson);

    return (disabilitiesDecoded as List).map(
      (educationDegreeMap) {
        return fromMap(
          map: educationDegreeMap,
        );
      },
    ).toList();
  }
}
