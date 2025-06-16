import 'dart:convert';

import '../../infra/models/sexual_orientation_model.dart';

class SexualOrientationModelMapper {
  SexualOrientationModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return SexualOrientationModel(
      id: map['id'],
      name: map['name'],
      sequence: map['sequence'],
    );
  }

  List<SexualOrientationModel> fromJsonList({
    required String sexualOrientationJson,
  }) {
    if (sexualOrientationJson.isEmpty) {
      return [];
    }

    final genderIdentitiesDecoded = jsonDecode(sexualOrientationJson);

    return (genderIdentitiesDecoded['contents'] as List).map(
      (sexualOrientationMap) {
        if (sexualOrientationMap['id'] == null) {}
        return fromMap(
          map: sexualOrientationMap,
        );
      },
    ).toList();
  }

  Map<String, dynamic> toMap({
    required SexualOrientationModel sexualOrientationModel,
  }) {
    return {
      'id': sexualOrientationModel.id,
      'name': sexualOrientationModel.name,
      'sequence': sexualOrientationModel.sequence,
    };
  }
}
