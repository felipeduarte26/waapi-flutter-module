import '../../domain/entities/social_mention_entity.dart';
import '../models/social_mention_model.dart';

class SocialMentionEntityAdapter {
  SocialMentionEntity fromModel({
    required SocialMentionModel model,
  }) {
    return SocialMentionEntity(
      mentionKey: model.mentionKey,
      mentionValue: model.mentionValue,
    );
  }
}
