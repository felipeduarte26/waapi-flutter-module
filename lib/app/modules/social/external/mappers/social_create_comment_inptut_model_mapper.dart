import '../../domain/intput_models/social_create_comment_intput_model.dart';
import 'social_attachment_input_model_mapper.dart';

class SocialCreateCommentInptutModelMapper {
  Map<String, dynamic> toJson({
    required SocialCreateCommentIntputModel socialCreateCommentInptutModel,
  }) {
    return {
      'postId': socialCreateCommentInptutModel.postId,
      'text': socialCreateCommentInptutModel.text,
      'parentId': socialCreateCommentInptutModel.parentId,
      'attachment': socialCreateCommentInptutModel.attachmentInptuModel != null
          ? SocialtAttachmentInputModelMapper().toJson(
              socialtAttachmentInputModelMapper: socialCreateCommentInptutModel.attachmentInptuModel!,
            )
          : null,
    };
  }
}
