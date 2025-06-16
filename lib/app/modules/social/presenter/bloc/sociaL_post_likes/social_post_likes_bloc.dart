import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_profiles_that_liked_post_usecase.dart';
import 'social_post_likes_event.dart';
import 'social_post_likes_state.dart';

class SocialPostLikesBloc extends Bloc<SocialPostLikesEvent, SocialPostLikesState> {
  final GetProfilesThatLikedPostUsecase _getProfilesThatLikedPostUsecase;

  SocialPostLikesBloc({
    required GetProfilesThatLikedPostUsecase getProfilesThatLikedPostUsecase,
  })  : _getProfilesThatLikedPostUsecase = getProfilesThatLikedPostUsecase,
        super(InitialSocialPostLikesState()) {
    on<GetSocialPostLikesEvent>(_getSocialPostLikesEvent);
  }

  Future<void> _getSocialPostLikesEvent(
    GetSocialPostLikesEvent event,
    Emitter<SocialPostLikesState> emit,
  ) async {
    final bool isAllowedToGetMorePostLikes = (state is! LoadingSocialPostLikesState &&
        state is! LastPageSocialPostLikesState &&
        state is! ErrorSocialPostLikesState);

    if (!isAllowedToGetMorePostLikes) {
      return;
    }

    if (state.profilesThatLiked != null && state.profilesThatLiked!.isEmpty) {
      emit(
        state.loadingSocialPostLikesState(),
      );
    } else {
      emit(
        state.loadingMoreSocialPostLikesState(),
      );
    }

    final profilesThatLiked = await _getProfilesThatLikedPostUsecase(
      postId: event.postId,
      paginationRequirements: event.paginationRequirements,
    );

    profilesThatLiked.fold((left) {
      if (state.profilesThatLiked!.isNotEmpty) {
        emit(state.errorLoadingMoreSocialPostLikesState());
      } else {
        emit(state.errorSocialPostLikesState());
      }
    }, (right) {
      if (right.isEmpty) {
        emit(
          state.lastPageSocialPostLikesState(
            profilesThatLiked: state.profilesThatLiked!,
          ),
        );
      } else {
        emit(
          state.loadedPageSocialPostLikesState(
            profilesThatLiked: state.profilesThatLiked != null ? state.profilesThatLiked! + right : right,
          ),
        );
      }
    });
  }
}
