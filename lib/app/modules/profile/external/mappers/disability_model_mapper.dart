import 'dart:convert';

import '../../infra/models/disability_model.dart';

const int code = -1;

class DisabilityModelMapper {
  DisabilityModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return DisabilityModel(
      id: map['id'],
      name: map['name'],
      code: map['code'] != null
          ? (map['code'] is int)
              ? map['code']
              : map['code'] == ''
                  ? code
                  : int.parse(map['code'])
          : null,
      type: map['type'],
    );
  }

  List<DisabilityModel> fromJsonList({
    required String disabilityJson,
  }) {
    if (disabilityJson.isEmpty) {
      return [];
    }

    final disabilitiesDecoded = jsonDecode(disabilityJson);

    return (disabilitiesDecoded as List).map(
      (disabilityMap) {
        if (disabilityMap['id'] == null) {}
        return fromMap(
          map: disabilityMap,
        );
      },
    ).toList();
  }

  Map<String, dynamic> toMap({
    required DisabilityModel disabilityModel,
  }) {
    return {
      'id': disabilityModel.id,
      'name': disabilityModel.name,
      'code': disabilityModel.code,
      'type': disabilityModel.type,
    };
  }
}
