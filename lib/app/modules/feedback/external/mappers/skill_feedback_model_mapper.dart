import 'dart:convert';

import '../../infra/models/skill_feedback_model.dart';

class SkillFeedbackModelMapper {
  SkillFeedbackModel fromMap({
    required Map<String, dynamic> skillMap,
  }) {
    return SkillFeedbackModel(
      id: skillMap['id'] ?? '',
      name: skillMap['name'] ?? '',
    );
  }

  List<SkillFeedbackModel> fromJsonList({
    required String skillsJson,
  }) {
    if (skillsJson.isEmpty) {
      return [];
    }

    final skillsDecoded = json.decode(skillsJson);

    final List<SkillFeedbackModel> skills = [];

    for (var skill in skillsDecoded as List) {
      final validSkill = skill['canBeUsedOnFeedback'] ?? 'N';
      
      if (validSkill.toString().toUpperCase() == 'S') {
        skills.add(
          fromMap(
            skillMap: skill,
          ),
        );
      }
    }

    return skills;
  }
}
