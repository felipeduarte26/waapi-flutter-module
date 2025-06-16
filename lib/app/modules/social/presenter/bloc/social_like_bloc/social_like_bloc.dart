import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/set_post_like_usecase.dart';
import 'social_like_event.dart';
import 'social_like_state.dart';

class SocialLikeBloc extends Bloc<SocialLikeEvent, SocialLikeState> {
  final SetPostLikeUsecase _setPostLikeUsecase;

  SocialLikeBloc({
    required SetPostLikeUsecase setPostLikeUsecase,
  })  : _setPostLikeUsecase = setPostLikeUsecase,
        super(const InitialSocialLikeState(likedPost: null, posts: [])) {
    on<SetSocialLikeEvent>(_setSocialLikeEvent);
  }

  Future<void> _setSocialLikeEvent(
    SetSocialLikeEvent event,
    Emitter<SocialLikeState> emit,
  ) async {
    int postIndex = event.posts.indexWhere((post) => post.id == event.postId);
    final post = event.posts[postIndex].copyWith(
      gotMyLike: event.isLiked,
      likeCount: event.isLiked ? event.posts[postIndex].likeCount + 1 : event.posts[postIndex].likeCount - 1,
    );
    event.posts[postIndex] = post;

    emit(
      LoadingSocialLikeState(
        posts: event.posts,
        likedPost: post,
        likeIsBlocked: true,
      ),
    );

    final socialLike = await _setPostLikeUsecase.call(
      postId: event.postId,
      isLiked: event.isLiked,
    );

    socialLike.fold(
      (left) {
        emit(
          ErrorSocialLikeState(
            posts: event.posts,
            likedPost: post,
          ),
        );

        final leftPosts = event.posts.map(
          (post) {
            if (post.id == event.postId) {
              return post.copyWith(
                gotMyLike: !event.isLiked,
                likeCount: !event.isLiked ? post.likeCount + 1 : post.likeCount - 1,
              );
            }

            return post;
          },
        ).toList();

        return emit(
          LoadedSocialLikeState(
            posts: leftPosts,
            likedPost: post,
            likeIsBlocked: false,
          ),
        );
      },
      (right) {
        return emit(
          LoadedSocialLikeState(
            likedPost: event.posts[postIndex],
            posts: state.posts,
            likeIsBlocked: false,
          ),
        );
      },
    );
  }
}
