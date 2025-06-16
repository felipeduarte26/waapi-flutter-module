import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/social_feed_entity.dart';
import '../../../domain/usecases/get_feed_usecase.dart';
import '../../../domain/usecases/share_post_for_members_usecase.dart';
import 'social_feed_event.dart';
import 'social_feed_state.dart';

class SocialFeedBloc extends Bloc<SocialFeedEvent, SocialFeedState> {
  final GetFeedUsecase _getFeedUsecase;
  final SharePostForMembersUsecase _sharePostForMemberUsecase;

  SocialFeedBloc({
    required GetFeedUsecase getFeedUsecase,
    required SharePostForMembersUsecase sharePostForMemberUsecase,
  })  : _getFeedUsecase = getFeedUsecase,
        _sharePostForMemberUsecase = sharePostForMemberUsecase,
        super(InitialSocialFeedState()) {
    on<GetSocialFeedEvent>(_getSocialFeedEvent);
    on<SharePostForMemberEvent>(_sharePostForMemberEvent);
  }

  Future<void> _getSocialFeedEvent(
    GetSocialFeedEvent event,
    Emitter<SocialFeedState> emit,
  ) async {
    event.socialFeedEntity == null
        ? emit(
            const LoadingSocialFeedState(
              socialFeedEntity: SocialFeedEntity(nextCursor: '', posts: [], fixedPost: null),
            ),
          )
        : emit(
            LoadingMoreSocialFeedState(socialFeedEntity: event.socialFeedEntity!),
          );

    final socialFeed = await _getFeedUsecase.call(
      nextCursor: event.nextCursor,
      paginationRequirements: event.paginationRequirements,
      since: event.since,
      space: event.space,
      tag: event.tag?.replaceAll('#', ''),
    );

    socialFeed.fold(
      (left) {
        if (event.socialFeedEntity != null) {
          return emit(ErrorLoadedMoreSocialFeedState(socialFeedEntity: event.socialFeedEntity!));
        }
        emit(
          const ErrorSocialFeedState(
            socialFeedEntity: SocialFeedEntity(
              nextCursor: '',
              posts: [],
              fixedPost: null,
            ),
          ),
        );
      },
      (right) {
        if (right.posts.isEmpty) {
          if (event.socialFeedEntity == null && right.fixedPost == null) {
            return emit(
              const EmptySocialFeedState(
                socialFeedEntity: SocialFeedEntity(nextCursor: '', posts: [], fixedPost: null),
              ),
            );
          }
          return emit(EmptyLoadedMoreSocialFeedState(socialFeedEntity: event.socialFeedEntity!));
        }

        if (event.socialFeedEntity != null) {
          final SocialFeedEntity socialFeedEntity;
          socialFeedEntity = SocialFeedEntity(
            nextCursor: right.nextCursor,
            fixedPost: right.fixedPost,
            posts: [
              ...event.socialFeedEntity!.posts,
              ...right.posts,
            ],
          );
          emit(
            LoadedMoreSocialFeedState(
              socialFeedEntity: socialFeedEntity,
            ),
          );
        } else {
          if (right.fixedPost != null) {
            right.posts.insert(0, right.fixedPost!);
          }
          emit(
            LoadedSocialFeedState(
              socialFeedEntity: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _sharePostForMemberEvent(
    SharePostForMemberEvent event,
    Emitter<SocialFeedState> emit,
  ) async {
    emit(
      LoadingSocialSharedPostState(
        socialFeedEntity: state.socialFeedEntity,
      ),
    );

    final socialShare = await _sharePostForMemberUsecase.call(
      postId: event.postId,
      membersId: event.membersId,
    );

    socialShare.fold(
      (left) {
        return emit(
          ErrorSocialSharedPostState(
            postId: event.postId,
            membersId: event.membersId,
            socialFeedEntity: state.socialFeedEntity,
          ),
        );
      },
      (right) {
        return emit(
          LoadedSocialSharedPostState(
            socialFeedEntity: state.socialFeedEntity,
          ),
        );
      },
    );
  }
}
