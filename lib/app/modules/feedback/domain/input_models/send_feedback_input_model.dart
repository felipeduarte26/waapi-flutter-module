import 'package:equatable/equatable.dart';

import '../../enums/feedback_visibility_enum.dart';
import 'proficiency_input_model.dart';
import 'skill_input_model.dart';

class SendFeedbackInputModel extends Equatable {
  final String message;
  final List<SkillInputModel> skills;
  final int starCount;
  final String toUserName;
  final FeedbackVisibilityEnum visibility;
  final ProficiencyInputModel? proficiency;
  final String? requestId;
  final DateTime when;

  const SendFeedbackInputModel({
    required this.message,
    required this.skills,
    this.starCount = 0,
    required this.toUserName,
    required this.visibility,
    this.proficiency,
    this.requestId,
    required this.when,
  });

  @override
  List<Object?> get props {
    return [
      message,
      skills,
      starCount,
      toUserName,
      visibility,
      proficiency,
      requestId,
      when,
    ];
  }
}
