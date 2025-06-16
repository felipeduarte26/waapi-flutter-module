import 'dart:convert';

import '../../infra/models/ethnicity_model.dart';

class EthnicityModelMapper {
  EthnicityModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return EthnicityModel(
      id: map['id'],
      name: map['name'],
      code: map['code'],
    );
  }

  EthnicityModel fromJson({required String ethnicityJson}) {
    return fromMap(
      map: json.decode(ethnicityJson),
    );
  }

  List<EthnicityModel> fromJsonList({
    required String ethnicityJson,
  }) {
    if (ethnicityJson.isEmpty) {
      return [];
    }
    final ethnicityDecode = jsonDecode(ethnicityJson);

    return (ethnicityDecode as List).map(
      (ethnicityMap) {
        return fromMap(
          map: ethnicityMap,
        );
      },
    ).toList();
  }
}
