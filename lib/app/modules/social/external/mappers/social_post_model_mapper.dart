import '../../../../core/helper/date_time_helper.dart';
import '../../infra/models/social_attachment_model.dart';
import '../../infra/models/social_comments_model.dart';
import '../../infra/models/social_group_model.dart';
import '../../infra/models/social_mention_model.dart';
import '../../infra/models/social_post_model.dart';
import '../../infra/models/social_profile_model.dart';
import 'social_attachment_model_mapper.dart';
import 'social_comments_model_mapper.dart';
import 'social_group_model_mapper.dart';
import 'social_mention_model_mapper.dart';
import 'social_profile_model_mapper.dart';
import 'social_space_model_mapper.dart';

class SocialPostModelMapper {
  SocialPostModel fromMap({
    required Map<String, dynamic> postMap,
  }) {
    return SocialPostModel(
      id: postMap['id'],
      author: SocialProfileModelMapper().fromMap(
        authorMap: postMap['author'],
      ),
      space: postMap['space'] != null
          ? SocialSpaceModelMapper().fromMap(
              map: postMap['space'],
            )
          : null,
      when: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: postMap['when'],
      )!,
      sticky: postMap['sticky'] != null
          ? DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: postMap['sticky'],
            )
          : null,
      read: postMap['read'] ?? false,
      text: postMap['text'],
      attachment: postMap['attachment'] != null
          ? SocialAttachmentModelMapper().fromMap(
              socialAttachmentMap: postMap['attachment'],
            )
          : null,
      attachments: postMap['attachments']
          ?.map<SocialAttachmentModel>(
            (attachmentMap) => SocialAttachmentModelMapper().fromMap(
              socialAttachmentMap: attachmentMap,
            ),
          )
          ?.toList(),
      comments: postMap['comments'] != null
          ? postMap['comments']
              .map<SocialCommentsModel>(
                (commentMap) => SocialCommentsModelMapper().fromMap(
                  commentMap: commentMap,
                ),
              )
              .toList()
          : List.empty(),
      commentCount: postMap['commentCount'],
      profilesThatLiked: postMap['profilesThatLiked']
          ?.map<SocialProfileModel>(
            (profileMap) => SocialProfileModelMapper().fromMap(
              authorMap: profileMap,
            ),
          )
          ?.toList(),
      likeCount: postMap['likeCount'],
      gotMyLike: postMap['gotMyLike'] ?? false,
      mentions: postMap['mentions']?.map<SocialMentionModel>(
        (mentionMap) {
          return SocialMentionModelMapper().fromMap(
            map: mentionMap,
          );
        },
      )?.toList(),
      isAuthor: postMap['isAuthor'] ?? false,
      groups: postMap['groups']?.map<SocialGroupModel>(
        (groupMap) {
          return SocialGroupModelMapper().fromMap(
            map: groupMap,
          );
        },
      )?.toList(),
      approved: postMap['approved'] ?? false,
      complained: postMap['complained'] ?? false,
      isFixed: postMap['isFixed'] ?? false,
      blockedComment: postMap['blockedComment'] ?? false,
    );
  }
}
