import '../../../../core/helper/date_time_helper.dart';
import '../../infra/models/social_comments_model.dart';
import '../../infra/models/social_mention_model.dart';
import '../../infra/models/social_profile_model.dart';
import 'social_attachment_model_mapper.dart';
import 'social_mention_model_mapper.dart';
import 'social_profile_model_mapper.dart';

class SocialCommentsModelMapper {
  SocialCommentsModel fromMap({
    required Map<String, dynamic> commentMap,
  }) {
    return SocialCommentsModel(
      id: commentMap['id'],
      author: SocialProfileModelMapper().fromMap(
        authorMap: commentMap['author'],
      ),
      when: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: commentMap['when'],
      )!,
      mentions: commentMap['mentions']?.map<SocialMentionModel>(
        (mentionMap) {
          return SocialMentionModelMapper().fromMap(
            map: mentionMap,
          );
        },
      )?.toList(),
      text: commentMap['text'],
      gotMyLike: commentMap['gotMyLike'],
      likeCount: commentMap['likeCount'],
      isAuthor: commentMap['isAuthor'] ?? false,
      complained: commentMap['complained'] ?? false,
      attachment: commentMap['attachment'] != null
          ? SocialAttachmentModelMapper().fromMap(
              socialAttachmentMap: commentMap['attachment'],
            )
          : null,
      children: commentMap['children']?.map<SocialCommentsModel>(
        (childMap) {
          return SocialCommentsModelMapper().fromMap(
            commentMap: childMap,
          );
        },
      )?.toList(),
      edited: commentMap['edited'] ?? false,
      isDenounciator: commentMap['isDenounciator'] ?? false,
      parent: commentMap['parent'],
      profilesThatLiked: commentMap['profilesThatLiked']?.map<SocialProfileModel>(
        (profileMap) {
          return SocialProfileModelMapper().fromMap(
            authorMap: profileMap,
          );
        },
      )?.toList(),
    );
  }

  List<SocialCommentsModel> fromListMap({
    required Map<String, dynamic> commentMap,
  }) {
    return (commentMap['comments'] as List<dynamic>?)?.map(
          (comment) {
            return fromMap(
              commentMap: comment,
            );
          },
        ).toList() ??
        const [];
  }
}
