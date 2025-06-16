import 'dart:convert';

import '../../infra/models/gender_identity_model.dart';

class GenderIdentityModelMapper {
  GenderIdentityModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return GenderIdentityModel(
      id: map['id'],
      name: map['name'],
      sequence: map['sequence'],
    );
  }

  List<GenderIdentityModel> fromJsonList({
    required String genderIdentityJson,
  }) {
    if (genderIdentityJson.isEmpty) {
      return [];
    }

    final genderIdentitiesDecoded = jsonDecode(genderIdentityJson);

    return (genderIdentitiesDecoded['contents'] as List).map(
      (genderIdentityMap) {
        if (genderIdentityMap['id'] == null) {}
        return fromMap(
          map: genderIdentityMap,
        );
      },
    ).toList();
  }

  Map<String, dynamic> toMap({
    required GenderIdentityModel genderIdentityModel,
  }) {
    return {
      'id': genderIdentityModel.id,
      'name': genderIdentityModel.name,
      'sequence': genderIdentityModel.sequence,
    };
  }
}
