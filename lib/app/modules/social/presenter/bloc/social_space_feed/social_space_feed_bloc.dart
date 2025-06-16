import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/types/either.dart';
import '../../../domain/entities/social_feed_entity.dart';
import '../../../domain/entities/social_space_entity.dart';
import '../../../domain/failures/social_failure.dart';
import '../../../domain/usecases/get_feed_usecase.dart';
import '../../../domain/usecases/get_space_info_usecase.dart';
import 'social_space_feed_event.dart';
import 'social_space_feed_state.dart';

class SocialSpaceFeedBloc extends Bloc<SocialSpaceFeedEvent, SocialSpaceFeedState> {
  final GetFeedUsecase _getFeedUsecase;
  final GetSpaceInfoUsecase _getSpaceInfoUsecase;

  String nextCursor = '';
  int nextPage = 1;

  SocialSpaceFeedBloc({
    required GetFeedUsecase getFeedUsecase,
    required GetSpaceInfoUsecase getSpaceInfoUsecase,
  })  : _getFeedUsecase = getFeedUsecase,
        _getSpaceInfoUsecase = getSpaceInfoUsecase,
        super(InitialSocialSpaceFeedState()) {
    on<GetSocialSpaceFeedEvent>(_getSocialSpaceFeedEvent);
  }

  Future<void> _getSocialSpaceFeedEvent(
    GetSocialSpaceFeedEvent event,
    Emitter<SocialSpaceFeedState> emit,
  ) async {
    if (event.socialFeedEntity == null) {
      nextPage = 1;
      nextCursor = '';
      emit(const LoadingSocialSpaceFeedState());
    } else {
      emit(
        LoadingMoreSocialSpaceFeedState(
          socialFeedEntity: event.socialFeedEntity!,
          space: event.space,
        ),
      );
    }

    if (event.space != null) {
      await _getFeed(event, emit);
      return;
    }

    await _getFeedAndSpace(event, emit);
  }

  Future<void> _getFeed(
    GetSocialSpaceFeedEvent event,
    Emitter<SocialSpaceFeedState> emit,
  ) async {
    Either<SocialFailure, SocialFeedEntity> feedResult = await _getFeedUsecase.call(
      nextCursor: nextCursor,
      since: event.since,
      space: event.spacePermaname,
      paginationRequirements: PaginationRequirements(page: nextPage),
    );

    _emitFeed(event, emit, feedResult, event.space!);
  }

  Future<void> _getFeedAndSpace(
    GetSocialSpaceFeedEvent event,
    Emitter<SocialSpaceFeedState> emit,
  ) async {
    Future<Either<SocialFailure, SocialFeedEntity>> fFeed = _getFeedUsecase.call(
      nextCursor: nextCursor,
      since: event.since,
      space: event.spacePermaname,
      paginationRequirements: PaginationRequirements(page: nextPage),
    );

    Future<Either<SocialFailure, SocialSpaceEntity>> fSpace = _getSpaceInfoUsecase.call(
      permaname: event.spacePermaname,
    );

    final (feedResult, spaceResult) = await (fFeed, fSpace).wait;

    spaceResult.fold(
      (left) {
        emit(
          const ErrorSocialSpaceFeedState(),
        );
      },
      (right) {
        _emitFeed(event, emit, feedResult, right);
      },
    );
  }

  void _emitFeed(
    GetSocialSpaceFeedEvent event,
    Emitter<SocialSpaceFeedState> emit,
    Either<SocialFailure, SocialFeedEntity> feedResult,
    SocialSpaceEntity space,
  ) {
    feedResult.fold(
      (left) {
        if (event.socialFeedEntity != null) {
          return emit(
            ErrorLoadedMoreSocialSpaceFeedState(
              socialFeedEntity: event.socialFeedEntity!,
              space: space,
            ),
          );
        }

        emit(
          const ErrorSocialSpaceFeedState(),
        );
      },
      (right) {
        if (right.posts.isEmpty) {
          if (event.socialFeedEntity == null) {
            return emit(EmptySocialSpaceFeedState(space: space));
          }
          return emit(
            EmptyLoadedMoreSocialSpaceFeedState(
              socialFeedEntity: event.socialFeedEntity!,
              space: space,
            ),
          );
        }

        nextPage++;
        nextCursor = right.nextCursor;
        if (event.socialFeedEntity == null) {
          return emit(
            LoadedSocialSpaceFeedState(
              socialFeedEntity: right,
              space: space,
            ),
          );
        }
        emit(
          LoadedMoreSocialSpaceFeedState(
            socialFeedEntity: event.socialFeedEntity!.copyWith(
              nextCursor: right.nextCursor,
              posts: [
                ...event.socialFeedEntity!.posts,
                ...right.posts,
              ],
            ),
            space: space,
          ),
        );
      },
    );
  }
}
