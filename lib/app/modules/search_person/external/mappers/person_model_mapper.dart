import 'dart:convert';

import '../../infra/models/person_model.dart';

class PersonModelMapper {
  PersonModel fromMap({
    required Map<String, dynamic> personMap,
  }) {
    return PersonModel(
      employeeId: personMap['employeeId'] ?? '',
      name: personMap['name'] ?? '',
      username: personMap['username'] ?? '',
      linkPhoto: personMap['linkPhoto'] ?? '',
      jobPosition: personMap['jobPosition'] ?? '',
    );
  }

  List<PersonModel> fromJsonList({
    required String? personJson,
  }) {
    if (personJson == null || personJson.isEmpty) {
      return [];
    }

    final Map<String, dynamic> resultMapData = json.decode(personJson);
    final personMapData = (resultMapData['list'] ?? []) as List;

    return (personMapData).map(
      (personMap) {
        return fromMap(
          personMap: personMap,
        );
      },
    ).toList();
  }
}
