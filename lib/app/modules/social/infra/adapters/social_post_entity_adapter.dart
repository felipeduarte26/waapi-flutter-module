import '../../domain/entities/social_post_entity.dart';
import '../models/social_post_model.dart';
import 'social_attachment_entity_adapter.dart';
import 'social_comments_entity_adapter.dart';
import 'social_group_entity_adapter.dart';
import 'social_mention_entity_adapter.dart';
import 'social_profile_entity_adapter.dart';
import 'social_space_entity_adapter.dart';

class SocialPostEntityAdapter {
  final SocialAttachmentEntityAdapter socialAttachmentEntityAdapter;
  final SocialProfileEntityAdapter authorEntityAdapter;
  final SocialSpaceEntityAdapter spaceEntityAdapter;
  final SocialGroupEntityAdapter socialGroupEntityAdapter;
  final SocialMentionEntityAdapter socialMentionEntityAdapter;
  final SocialCommentsEntityAdapter socialCommentsEntityAdapter;

  const SocialPostEntityAdapter({
    required this.socialAttachmentEntityAdapter,
    required this.authorEntityAdapter,
    required this.spaceEntityAdapter,
    required this.socialGroupEntityAdapter,
    required this.socialMentionEntityAdapter,
    required this.socialCommentsEntityAdapter,
  });

  SocialPostEntity fromModel({
    required SocialPostModel postModel,
  }) {
    return SocialPostEntity(
      id: postModel.id,
      author: authorEntityAdapter.fromModel(
        authorModel: postModel.author,
      ),
      space: postModel.space != null
          ? spaceEntityAdapter.fromModel(
              spaceModel: postModel.space!,
            )
          : null,
      when: postModel.when,
      sticky: postModel.sticky,
      read: postModel.read,
      text: postModel.text,
      attachments: postModel.attachments?.map(
        (attachment) {
          return socialAttachmentEntityAdapter.fromModel(
            socialAttachmentModel: attachment,
          );
        },
      ).toList(),
      attachment: postModel.attachment != null
          ? socialAttachmentEntityAdapter.fromModel(
              socialAttachmentModel: postModel.attachment!,
            )
          : null,
      comments: postModel.comments.map(
        (comment) {
          return socialCommentsEntityAdapter.fromModel(
            model: comment,
          );
        },
      ).toList(),
      commentCount: postModel.commentCount,
      profilesThatLiked: postModel.profilesThatLiked?.map(
        (profile) {
          return authorEntityAdapter.fromModel(
            authorModel: profile,
          );
        },
      ).toList(),
      likeCount: postModel.likeCount,
      gotMyLike: postModel.gotMyLike,
      mentions: postModel.mentions?.map(
        (mention) {
          return socialMentionEntityAdapter.fromModel(
            model: mention,
          );
        },
      ).toList(),
      isAuthor: postModel.isAuthor,
      groups: postModel.groups?.map(
        (group) {
          return socialGroupEntityAdapter.fromModel(
            model: group,
          );
        },
      ).toList(),
      approved: postModel.approved,
      complained: postModel.complained,
      isFixed: postModel.isFixed,
      blockedComment: postModel.blockedComment,
    );
  }
}
