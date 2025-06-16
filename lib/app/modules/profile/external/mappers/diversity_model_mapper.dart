import 'dart:convert';

import '../../infra/models/diversity_model.dart';
import 'diversity_person_model_mapper.dart';

class DiversityModelMapper {
  DiversityModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return DiversityModel(
      id: map['id'],
      diversity: map['diversity'] != null
          ? DiversityPersonModelMapper().fromMap(
              map: map['diversity'],
            )
          : null,
      personId: map['domainEntityId'],
    );
  }

  DiversityModel? fromJsonList({
    required String diversityJson,
  }) {
    if (diversityJson.isEmpty) {
      return null;
    }

    final diversityDecoded = jsonDecode(diversityJson);

    final diversityMap = (diversityDecoded['contents'] ?? []) as List;

    if (diversityMap.isEmpty) {
      return null;
    }

    return fromMap(
      map: diversityMap.first,
    );
  }
}
