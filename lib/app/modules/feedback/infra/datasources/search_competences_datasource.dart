import '../models/skill_feedback_model.dart';

abstract class SearchCompetencesDatasource {
  Future<List<SkillFeedbackModel>> call({
    required String competency,
  });
}
