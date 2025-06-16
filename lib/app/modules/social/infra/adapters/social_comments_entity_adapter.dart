import '../../domain/entities/social_comments_entity.dart';
import '../models/social_comments_model.dart';
import 'social_attachment_entity_adapter.dart';
import 'social_mention_entity_adapter.dart';
import 'social_profile_entity_adapter.dart';

class SocialCommentsEntityAdapter {
  SocialCommentsEntity fromModel({
    required SocialCommentsModel model,
  }) {
    return SocialCommentsEntity(
      id: model.id,
      author: SocialProfileEntityAdapter().fromModel(
        authorModel: model.author,
      ),
      when: model.when,
      text: model.text,
      mentions: model.mentions?.map(
              (mention) {
                return SocialMentionEntityAdapter().fromModel(
                  model: mention,
                );
              },
            ).toList()
          ,
      likeCount: model.likeCount,
      gotMyLike: model.gotMyLike,
      profilesThatLiked: model.profilesThatLiked?.map(
              (profile) {
                return SocialProfileEntityAdapter().fromModel(
                  authorModel: profile,
                );
              },
            ).toList()
          ,
      parent: model.parent,
      children: model.children?.map(
              (child) {
                return SocialCommentsEntityAdapter().fromModel(
                  model: child,
                );
              },
            ).toList()
          ,
      complained: model.complained,
      isDenounciator: model.isDenounciator,
      isAuthor: model.isAuthor,
      edited: model.edited,
      attachment: model.attachment != null
          ? SocialAttachmentEntityAdapter().fromModel(
              socialAttachmentModel: model.attachment!,
            )
          : null,
    );
  }
}
