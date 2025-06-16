import 'dart:convert';

import '../../infra/models/proficiency_feedback_model.dart';

class ProficiencyFeedbackModelMapper {
  ProficiencyFeedbackModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return ProficiencyFeedbackModel(
      id: map['id'] ?? '',
      color: map['color'] ?? '#080808',
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
      level: map['level'] ?? '',
      needJustify: (map['needJustify'] is String) ? false : map['needJustify'],
      needPDI: (map['needPDI'] is String) ? false : map['needPDI'],
      valueOfScore: map['valueOfScore'] ?? 0.0,
    );
  }

  List<ProficiencyFeedbackModel> fromJsonList({
    required String proficienciesJson,
  }) {
    if (proficienciesJson.isEmpty) {
      return [];
    }

    final proficienciesDecoded = json.decode(proficienciesJson);

    return (proficienciesDecoded as List).map(
      (proficiencyMap) {
        return fromMap(
          map: proficiencyMap,
        );
      },
    ).toList();
  }
}
