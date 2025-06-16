import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/send_feedback_input_model.dart';
import '../../enums/feedback_visibility_enum.dart';
import 'proficiency_input_model_mapper.dart';
import 'skill_input_model_mapper.dart';

class SendFeedbackInputModelMapper {
  Map<String, dynamic> toMap({
    required SendFeedbackInputModel sendFeedbackInputModel,
  }) {
    return {
      'message': sendFeedbackInputModel.message,
      'skills': sendFeedbackInputModel.skills.map(
        (skillInputModel) {
          return SkillInputModelMapper().toMap(
            skillInputModel: skillInputModel,
          );
        },
      ).toList(),
      'starCount': sendFeedbackInputModel.starCount,
      'toUserName': sendFeedbackInputModel.toUserName,
      'visibility': EnumHelper<FeedbackVisibilityEnum>().enumToString(
        enumToParse: sendFeedbackInputModel.visibility,
      ),
      'level': sendFeedbackInputModel.proficiency != null
          ? ProficiencyInputModelMapper().toMap(
              proficiencyInputModel: sendFeedbackInputModel.proficiency!,
            )
          : <String, dynamic>{},
      'requestId': sendFeedbackInputModel.requestId,
      'when': sendFeedbackInputModel.when.toUtc().toIso8601String(),
    }..removeWhere(
        (key, value) {
          return key == 'skills' && value is List && value.isEmpty;
        },
      );
  }
}
