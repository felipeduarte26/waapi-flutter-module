import '../../domain/intput_models/social_create_post_input_model.dart';
import 'social_attachment_input_model_mapper.dart';

class SocialCreatePostInputModelMapper {
  Map<String, dynamic> toJson({
    required SocialCreatePostInputModel socialCreatePostIntputModel,
  }) {
    return {
      'text': socialCreatePostIntputModel.text,
      'groups': socialCreatePostIntputModel.groups,
      'blockedComment': socialCreatePostIntputModel.blockedComment,
      'space': socialCreatePostIntputModel.space,
      'when': socialCreatePostIntputModel.when,
      'profileId': socialCreatePostIntputModel.profileId,
      'attachments': socialCreatePostIntputModel.attachments
          ?.map(
            (e) => SocialtAttachmentInputModelMapper().toJson(
              socialtAttachmentInputModelMapper: e,
            ),
          )
          .toList(),
    };
  }
}
