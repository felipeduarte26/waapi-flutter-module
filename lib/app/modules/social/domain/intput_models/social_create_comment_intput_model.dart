import 'package:equatable/equatable.dart';

import 'social_attachment_input_model.dart';

class SocialCreateCommentIntputModel extends Equatable {
  final String postId;
  final String text;
  final String? parentId;
  final SocialAttachmentInputModel? attachmentInptuModel;

  const SocialCreateCommentIntputModel({
    required this.postId,
    required this.text,
    this.parentId,
    this.attachmentInptuModel,
  });

  @override
  List<Object?> get props => [
        postId,
        text,
        parentId,
        attachmentInptuModel,
      ];
}
