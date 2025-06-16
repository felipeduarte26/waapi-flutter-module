import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_comments_entity.dart';
import '../../../domain/intput_models/social_create_comment_intput_model.dart';

abstract class SocialCommentsState extends Equatable {
  final List<SocialCommentsEntity> socialComments;

  const SocialCommentsState({
    this.socialComments = const [],
  });

  @override
  List<Object?> get props {
    return [
      socialComments,
    ];
  }
}

class InitialSocialCommentsState extends SocialCommentsState {
  const InitialSocialCommentsState({required super.socialComments});
}

class LoadingSocialCommentsState extends SocialCommentsState {
  const LoadingSocialCommentsState({required super.socialComments});
}

class EmptySocialCommentsState extends SocialCommentsState {}

class LoadedSocialCommentsState extends SocialCommentsState {
  const LoadedSocialCommentsState({
    required List<SocialCommentsEntity> socialComments,
  }) : super(socialComments: socialComments);

  @override
  List<Object> get props {
    return [
      socialComments,
    ];
  }
}

class ErrorSocialCommentsState extends SocialCommentsState {
  const ErrorSocialCommentsState({required super.socialComments});
}

class LoadedSocialLikeCommentState extends SocialCommentsState {
  const LoadedSocialLikeCommentState({required super.socialComments});
}

class ErrorSocialLikeCommentState extends SocialCommentsState {
  final String commentId;
  final String? answerId;
  final bool isLiked;

  const ErrorSocialLikeCommentState({
    required this.commentId,
    required this.isLiked,
    this.answerId,
    required List<SocialCommentsEntity> socialComments,
  }) : super(socialComments: socialComments);

  @override
  List<Object?> get props => [
        commentId,
        answerId,
        isLiked,
      ];
}

class LoadedSocialCreateCommentState extends SocialCommentsState {
  const LoadedSocialCreateCommentState({
    required List<SocialCommentsEntity> socialComments,
  }) : super(socialComments: socialComments);
}

class ErrorSocialCreateCommentState extends SocialCommentsState {
  final SocialCreateCommentIntputModel socialCreateCommentIntputModel;

  const ErrorSocialCreateCommentState({
    required this.socialCreateCommentIntputModel,
    required List<SocialCommentsEntity> socialComments,
  }) : super(socialComments: socialComments);

  @override
  List<Object?> get props => [
        socialCreateCommentIntputModel,
      ];
}
