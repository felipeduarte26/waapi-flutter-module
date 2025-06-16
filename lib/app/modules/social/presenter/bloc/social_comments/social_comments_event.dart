import 'package:equatable/equatable.dart';

import '../../../domain/intput_models/social_create_comment_intput_model.dart';

abstract class SocialCommentsEvent extends Equatable {}

class GetSocialCommentsEvent extends SocialCommentsEvent {
  final String postId;

  GetSocialCommentsEvent({
    required this.postId,
  });

  @override
  List<Object?> get props {
    return [
      postId,
    ];
  }
}

class SetSocialLikeCommentEvent extends SocialCommentsEvent {
  final String commentId;
  final String? answerId;
  final bool isLiked;

  SetSocialLikeCommentEvent({
    required this.commentId,
    required this.isLiked,
    this.answerId,
  });

  @override
  List<Object?> get props {
    return [
      commentId,
      isLiked,
      answerId,
    ];
  }
}

class CreateSocialCommentEvent extends SocialCommentsEvent {
  final SocialCreateCommentIntputModel socialCreateCommentIntputModel;

  CreateSocialCommentEvent({
    required this.socialCreateCommentIntputModel,
  });

  @override
  List<Object?> get props {
    return [
      socialCreateCommentIntputModel,
    ];
  }
}
