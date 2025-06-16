import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/types/either.dart';
import '../../../domain/entities/social_feed_entity.dart';
import '../../../domain/failures/social_failure.dart';
import '../../../domain/usecases/get_feed_usecase.dart';
import 'social_tag_feed_event.dart';
import 'social_tag_feed_state.dart';

class SocialTagFeedBloc extends Bloc<SocialTagFeedEvent, SocialTagFeedState> {
  final GetFeedUsecase _getFeedUsecase;
  String nextCursor = '';
  int nextPage = 0;

  SocialTagFeedBloc({
    required GetFeedUsecase getFeedUsecase,
  })  : _getFeedUsecase = getFeedUsecase,
        super(InitialSocialTagFeedState()) {
    on<GetSocialTagFeedEvent>(_getSocialTagFeedEvent);
  }

  void _getSocialTagFeedEvent(
    GetSocialTagFeedEvent event,
    Emitter<SocialTagFeedState> emit,
  ) async {
    if (event.socialFeedEntity == null) {
      nextCursor = '';
      nextPage = 0;
      emit(LoadingSocialTagFeedState());
    } else {
      emit(
        LoadingMoreSocialTagFeedState(
          socialFeedEntity: event.socialFeedEntity!,
        ),
      );
    }

    final feedResult = await _getFeedUsecase.call(
      nextCursor: nextCursor,
      paginationRequirements: PaginationRequirements(page: nextPage),
      since: event.since,
      tag: event.tag.replaceAll('#', '').toLowerCase(),
    );

    _emitFeed(event, emit, feedResult);
  }

  void _emitFeed(
    GetSocialTagFeedEvent event,
    Emitter<SocialTagFeedState> emit,
    Either<SocialFailure, SocialFeedEntity> feedResult,
  ) {
    bool isEventFeedEntityNull = event.socialFeedEntity == null;

    feedResult.fold(
      (left) {
        isEventFeedEntityNull
            ? emit(ErrorSocialTagFeedState())
            : emit(
                ErrorLoadedMoreSocialTagFeedState(),
              );
      },
      (right) {
        if (right.posts.isEmpty) {
          return isEventFeedEntityNull
              ? emit(EmptySocialTagFeedState())
              : emit(EmptyLoadedMoreSocialTagFeedState(socialFeedEntity: event.socialFeedEntity!));
        }

        nextPage++;
        nextCursor = right.nextCursor;
        return isEventFeedEntityNull
            ? emit(LoadedSocialTagFeedState(socialFeedEntity: right))
            : emit(
                LoadedMoreSocialTagFeedState(
                  socialFeedEntity: event.socialFeedEntity!.copyWith(
                    nextCursor: right.nextCursor,
                    posts: [
                      ...event.socialFeedEntity!.posts,
                      ...right.posts,
                    ],
                  ),
                ),
              );
      },
    );
  }
}
