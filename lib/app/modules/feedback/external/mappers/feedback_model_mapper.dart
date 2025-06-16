import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../../attachment/external/mappers/attachment_model_mapper.dart';
import '../../enums/feedback_type_enum.dart';
import '../../enums/feedback_visibility_enum.dart';
import '../../infra/models/feedback_model.dart';
import 'proficiency_feedback_model_mapper.dart';
import 'skill_feedback_model_mapper.dart';

class FeedbackModelMapper {
  final ProficiencyFeedbackModelMapper _proficiencyFeedbackModelMapper;
  final AttachmentModelMapper _attachmentModelMapper;
  final SkillFeedbackModelMapper _skillFeedbackModelMapper;

  const FeedbackModelMapper({
    required ProficiencyFeedbackModelMapper proficiencyFeedbackModelMapper,
    required AttachmentModelMapper attachmentModelMapper,
    required SkillFeedbackModelMapper skillFeedbackModelMapper,
  })  : _proficiencyFeedbackModelMapper = proficiencyFeedbackModelMapper,
        _attachmentModelMapper = attachmentModelMapper,
        _skillFeedbackModelMapper = skillFeedbackModelMapper;

  FeedbackModel fromMap({
    required Map<String, dynamic> map,
    FeedbackTypeEnum? feedbackType,
  }) {
    return FeedbackModel(
      feedbackType: feedbackType,
      id: map['id'],
      when: DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: map['when'],
      ),
      fromId: map['fromId'] ?? '',
      fromName: map['fromName'] ?? '',
      fromPhotoUrl: map['linkPhotoFrom'] ?? '',
      fromUsername: map['fromUsername'] ?? '',
      toId: map['toId'] ?? '',
      toName: map['toName'] ?? '',
      toUsername: map['toUsername'] ?? '',
      toPhotoUrl: map['linkPhotoTo'] ?? '',
      message: map['message'],
      isPublic: (map['isPublic'] is String) ? false : map['isPublic'],
      visibility: EnumHelper<FeedbackVisibilityEnum>().stringToEnum(
            stringToParse: map['visibility'],
            values: FeedbackVisibilityEnum.values,
          ) ??
          FeedbackVisibilityEnum.employee,
      starCount: map['starCount'] ?? 0,
      proficiency: map['level'] == null
          ? null
          : _proficiencyFeedbackModelMapper.fromMap(
              map: map['level'],
            ),
      attachments: map['attachments'] == null
          ? null
          : (map['attachments'] as List).map(
              (attachment) {
                return _attachmentModelMapper.fromMap(
                  map: attachment,
                );
              },
            ).toList(),
      skills: map['skills'] == null
          ? null
          : (map['skills'] as List).where(
              (skill) {
                return (skill as Map<String, dynamic>).containsKey('competency');
              },
            ).map(
              (skill) {
                return _skillFeedbackModelMapper.fromMap(
                  skillMap: skill['competency'],
                );
              },
            ).toList(),
    );
  }

  FeedbackModel fromJson({
    required String json,
    FeedbackTypeEnum? feedbackType,
  }) {
    return fromMap(
      map: jsonDecode(json),
      feedbackType: feedbackType,
    );
  }
}
