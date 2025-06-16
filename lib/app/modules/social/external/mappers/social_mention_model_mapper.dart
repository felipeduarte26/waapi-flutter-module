import '../../infra/models/social_mention_model.dart';

class SocialMentionModelMapper {
  SocialMentionModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return SocialMentionModel(
      mentionKey: map['key'],
      mentionValue: map['value'],
    );
  }
}
