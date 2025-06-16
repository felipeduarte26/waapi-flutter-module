import '../models/proficiency_feedback_model.dart';

abstract class GetProficiencyListDatasource {
  Future<List<ProficiencyFeedbackModel>> call();
}
