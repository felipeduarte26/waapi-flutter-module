import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/social_comments_entity.dart';
import '../../../domain/usecases/create_comment_usecase.dart';
import '../../../domain/usecases/get_comments_usecase.dart';
import '../../../domain/usecases/set_like_comment_usecase.dart';
import 'social_comments_event.dart';
import 'social_comments_state.dart';

class SocialCommentsBloc extends Bloc<SocialCommentsEvent, SocialCommentsState> {
  final GetCommentsUsecase _getCommentsUsecase;
  final SetLikeCommentUsecase _setLikeCommentUsecase;
  final CreateCommentUsecase _createCommentUsecase;

  SocialCommentsBloc({
    required GetCommentsUsecase getCommentsUsecase,
    required SetLikeCommentUsecase setLikeCommentUsecase,
    required CreateCommentUsecase createCommentUsecase,
  })  : _getCommentsUsecase = getCommentsUsecase,
        _setLikeCommentUsecase = setLikeCommentUsecase,
        _createCommentUsecase = createCommentUsecase,
        super(const InitialSocialCommentsState(socialComments: [])) {
    on<GetSocialCommentsEvent>(_getSocialCommentsEvent);
    on<SetSocialLikeCommentEvent>(_setSocialLikeCommentEvent);
    on<CreateSocialCommentEvent>(_createSocialCommentEvent);
  }

  Future<void> _getSocialCommentsEvent(
    GetSocialCommentsEvent event,
    Emitter<SocialCommentsState> emit,
  ) async {
    emit(
      LoadingSocialCommentsState(
        socialComments: state.socialComments,
      ),
    );

    final socialComments = await _getCommentsUsecase.call(
      postId: event.postId,
    );

    socialComments.fold(
      (left) {
        return emit(ErrorSocialCommentsState(socialComments: state.socialComments));
      },
      (right) {
        if (right.isEmpty) {
          return emit(EmptySocialCommentsState());
        }

        return emit(
          LoadedSocialCommentsState(
            socialComments: right,
          ),
        );
      },
    );
  }

  Future<void> _setSocialLikeCommentEvent(
    SetSocialLikeCommentEvent event,
    Emitter<SocialCommentsState> emit,
  ) async {
    final comments = _updateComments(
      commentId: event.commentId,
      isLiked: event.isLiked,
      answerId: event.answerId,
    );

    emit(
      LoadedSocialCommentsState(
        socialComments: comments,
      ),
    );

    final socialLike = await _setLikeCommentUsecase.call(
      commentId: event.answerId ?? event.commentId,
      isLiked: event.isLiked,
    );

    socialLike.fold(
      (left) {
        emit(
          ErrorSocialLikeCommentState(
            commentId: event.commentId,
            answerId: event.answerId,
            isLiked: event.isLiked,
            socialComments: comments,
          ),
        );

        final leftComments = _updateComments(
          commentId: event.commentId,
          isLiked: !event.isLiked,
          answerId: event.answerId,
        );

        emit(
          LoadedSocialLikeCommentState(
            socialComments: leftComments,
          ),
        );

        return emit(
          LoadedSocialCommentsState(
            socialComments: leftComments,
          ),
        );
      },
      (right) {
        emit(
          LoadedSocialLikeCommentState(
            socialComments: comments,
          ),
        );

        return emit(
          LoadedSocialCommentsState(
            socialComments: comments,
          ),
        );
      },
    );
  }

  List<SocialCommentsEntity> _updateComments({required bool isLiked, required String commentId, String? answerId}) {
    return state.socialComments.map(
      (comment) {
        if (comment.id == commentId) {
          if (answerId != null) {
            final answers = comment.children?.map((answer) {
              if (answer.id == answerId) {
                return answer.copyWith(
                  gotMyLike: isLiked,
                  likeCount: isLiked ? answer.likeCount + 1 : answer.likeCount - 1,
                );
              }
              return answer;
            }).toList();

            return comment.copyWith(
              children: answers,
            );
          }

          return comment.copyWith(
            gotMyLike: isLiked,
            likeCount: isLiked ? comment.likeCount + 1 : comment.likeCount - 1,
          );
        }

        return comment;
      },
    ).toList();
  }

  Future<void> _createSocialCommentEvent(
    CreateSocialCommentEvent event,
    Emitter<SocialCommentsState> emit,
  ) async {
    final socialComments = state.socialComments;

    emit(
      LoadingSocialCommentsState(
        socialComments: socialComments,
      ),
    );

    final createComment = await _createCommentUsecase.call(
      socialCreateCommentIntputModel: event.socialCreateCommentIntputModel,
    );

    createComment.fold(
      (left) {
        emit(
          ErrorSocialCreateCommentState(
            socialCreateCommentIntputModel: event.socialCreateCommentIntputModel,
            socialComments: socialComments,
          ),
        );

        return emit(
          LoadedSocialCommentsState(
            socialComments: socialComments,
          ),
        );
      },
      (right) {
        List<SocialCommentsEntity> comments = [];

        if (event.socialCreateCommentIntputModel.parentId == null) {
          comments.addAll(socialComments);
          comments.add(right);
        } else {
          socialComments.map(
            (comment) {
              if (comment.id == event.socialCreateCommentIntputModel.parentId) {
                final List<SocialCommentsEntity> answers = comment.children ?? [];
                answers.add(right);

                comments.add(
                  comment.copyWith(
                    children: answers,
                  ),
                );
              } else {
                comments.add(comment);
              }
            },
          ).toList();
        }

        emit(
          LoadedSocialCreateCommentState(
            socialComments: comments,
          ),
        );

        return emit(
          LoadedSocialCommentsState(
            socialComments: comments,
          ),
        );
      },
    );
  }
}
