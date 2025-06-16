import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/types/either.dart';
import '../../../domain/entities/social_post_entity.dart';
import '../../../domain/entities/social_profile_entity.dart';
import '../../../domain/failures/social_failure.dart';
import '../../../domain/usecases/get_profile_posts_usecase.dart';
import '../../../domain/usecases/get_social_profile_usecase.dart';
import 'social_profile_posts_event.dart';
import 'social_profile_posts_state.dart';

class SocialProfilePostsBloc extends Bloc<SocialProfilePostsEvent, SocialProfilePostsState> {
  final GetProfilePostsUsecase _getProfilePostsUsecase;
  final GetSocialProfileUsecase _getSocialProfileUsecase;
  int nextPage = 1;

  SocialProfilePostsBloc({
    required GetProfilePostsUsecase getProfilePostsUsecase,
    required GetSocialProfileUsecase getSocialProfileUsecase,
  })  : _getProfilePostsUsecase = getProfilePostsUsecase,
        _getSocialProfileUsecase = getSocialProfileUsecase,
        super(InitialSocialProfilePostsState()) {
    on<GetSocialProfilePostsEvent>(_getSocialProfilePostsEvent);
  }

  Future<void> _getSocialProfilePostsEvent(
    GetSocialProfilePostsEvent event,
    Emitter<SocialProfilePostsState> emit,
  ) async {
    if (event.socialPostsEntity.isEmpty) {
      nextPage = 1;
      emit(
        const LoadingSocialProfilePostsState(
          socialPostsEntity: [],
        ),
      );
    } else {
      emit(
        LoadingMoreSocialProfilePostsState(
          socialPostsEntity: event.socialPostsEntity,
          socialProfileEntity: event.socialProfileEntity,
        ),
      );
    }

    if (event.socialProfileEntity != null) {
      await _getPosts(event, emit);
      return;
    }

    await _getPostsAndProfile(event, emit);
  }

  Future<void> _getPosts(GetSocialProfilePostsEvent event, Emitter<SocialProfilePostsState> emit) async {
    Either<SocialFailure, List<SocialPostEntity>> postsResult = await _getProfilePostsUsecase.call(
      paginationRequirements: PaginationRequirements(page: nextPage),
      permaname: event.permaname,
      lastSeenId: event.lastSeenId,
    );

    _emitPosts(event, emit, postsResult, event.socialProfileEntity!);
  }

  Future<void> _getPostsAndProfile(GetSocialProfilePostsEvent event, Emitter<SocialProfilePostsState> emit) async {
    Future<Either<SocialFailure, List<SocialPostEntity>>> fPosts = _getProfilePostsUsecase.call(
      paginationRequirements: PaginationRequirements(page: nextPage),
      permaname: event.permaname,
      lastSeenId: event.lastSeenId,
    );
    Future<Either<SocialFailure, SocialProfileEntity>> fProfile = _getSocialProfileUsecase.call(
      permaname: event.permaname,
    );

    final (postsResult, profileResult) = await (fPosts, fProfile).wait;

    profileResult.fold((left) {
      emit(
        const ErrorSocialProfilePostsState(
          socialPostsEntity: [],
        ),
      );
    }, (right) {
      _emitPosts(event, emit, postsResult, right);
    });
  }

  void _emitPosts(
    GetSocialProfilePostsEvent event,
    Emitter<SocialProfilePostsState> emit,
    Either<SocialFailure, List<SocialPostEntity>> postsResult,
    SocialProfileEntity profile,
  ) {
    postsResult.fold(
      (left) {
        if (event.socialPostsEntity.isNotEmpty) {
          return emit(ErrorLoadedMoreSocialProfilePostsState(socialPostsEntity: event.socialPostsEntity));
        }
        emit(
          const ErrorSocialProfilePostsState(
            socialPostsEntity: [],
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          if (event.socialPostsEntity.isEmpty) {
            return emit(
              const EmptySocialProfilePostsState(
                socialPostsEntity: [],
              ),
            );
          }
          return emit(
            EmptyLoadedMoreSocialProfilePostsState(
              socialPostsEntity: event.socialPostsEntity,
              socialProfileEntity: profile,
            ),
          );
        }

        nextPage++;
        if (event.socialPostsEntity.isNotEmpty) {
          emit(
            LoadedMoreSocialProfilePostsState(
              socialPostsEntity: [
                ...event.socialPostsEntity,
                ...right,
              ],
              socialProfileEntity: profile,
            ),
          );
        } else {
          emit(
            LoadedSocialProfilePostsState(
              socialPostsEntity: right,
              socialProfileEntity: profile,
            ),
          );
        }
      },
    );
  }
}
