import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_bloc.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../home/presenter/bloc/connectivity_bloc/connectivity_bloc.dart';
import '../../../../profile/presenter/blocs/profile_bloc/profile_bloc.dart';
import '../get_short_url_bloc/get_short_url_bloc.dart';
import '../sociaL_post_likes/social_post_likes_bloc.dart';
import '../social_comments/social_comments_bloc.dart';
import '../social_create_post/social_create_post_bloc.dart';
import '../social_current_profile/social_current_profile_bloc.dart';
import '../social_feed/social_feed_bloc.dart';
import '../social_files/social_get_file_upload_bloc.dart';
import '../social_get_url_post/get_url_post_bloc.dart';
import '../social_hashtags/social_hashtags_bloc.dart';
import '../social_like_bloc/social_like_bloc.dart';
import '../social_list_members/social_list_members_bloc.dart';
import '../social_mentions/social_mentions_bloc.dart';
import '../social_profile_photo/read_profile_photo_url_bloc.dart';
import '../social_profiles/social_profiles_bloc.dart';
import '../social_spaces/social_spaces_bloc.dart';
import 'social_screen_event.dart';
import 'social_screen_state.dart';

class SocialScreenBloc extends Bloc<SocialScreenEvent, SocialScreenState> {
  final AuthorizationBloc authorizationBloc;
  final SocialFeedBloc socialFeedBloc;
  final ConnectivityBloc connectivityBloc;
  final SocialCommentsBloc socialCommentsBloc;
  final ReadProfilePhotoURLBloc readProfilePhotoURLBloc;
  final SocialListMembersBloc listMembersBloc;
  final GetURLPostBloc urlPostBloc;
  final AttachmentBloc shareStringBloc;
  final SocialGetFileUploadBloc fileUploadBloc;
  final SocialHashtagsBloc hashtagsBloc;
  final SocialMentionsBloc mentionsBloc;
  final ProfileBloc profileBloc;
  final GetShortUrlBloc shortUrlBloc;
  final SocialSpacesBloc socialSpacesBloc;
  final SocialProfilesBloc socialProfilesBloc;
  final SocialCreatePostBloc socialCreatePostBloc;
  final SocialCurrentProfileBloc socialCurrentProfileBloc;
  final SocialPostLikesBloc socialPostLikesBloc;
  final SocialLikeBloc socialLikeBloc;

  late StreamSubscription authorizationSubscription;
  late StreamSubscription socialFeedSubscription;
  late StreamSubscription connectivitySubscription;
  late StreamSubscription readProfilePhotoSubscription;
  late StreamSubscription socialCommentsSubscription;
  late StreamSubscription listMembersSubscription;
  late StreamSubscription urlPostSubscription;
  late StreamSubscription shareStringSubscription;
  late StreamSubscription fileUploadSubscription;
  late StreamSubscription hashtagsSubscription;
  late StreamSubscription mentionsSubscription;
  late StreamSubscription profileSubscription;
  late StreamSubscription shortUrlSubscription;
  late StreamSubscription socialSpacesSubscription;
  late StreamSubscription socialProfilesSubscription;
  late StreamSubscription socialCreatePostSubscription;
  late StreamSubscription socialCurrentProfileSubscription;
  late StreamSubscription socialPostLikesSubscription;
  late StreamSubscription socialLikeSubscription;

  SocialScreenBloc({
    required this.authorizationBloc,
    required this.socialFeedBloc,
    required this.connectivityBloc,
    required this.socialCommentsBloc,
    required this.readProfilePhotoURLBloc,
    required this.listMembersBloc,
    required this.urlPostBloc,
    required this.shareStringBloc,
    required this.fileUploadBloc,
    required this.hashtagsBloc,
    required this.mentionsBloc,
    required this.profileBloc,
    required this.shortUrlBloc,
    required this.socialSpacesBloc,
    required this.socialProfilesBloc,
    required this.socialCreatePostBloc,
    required this.socialCurrentProfileBloc,
    required this.socialPostLikesBloc,
    required this.socialLikeBloc,
  }) : super(
          CurrentSocialScreenState(
            authorizationState: authorizationBloc.state,
            socialFeedState: socialFeedBloc.state,
            connectivityState: connectivityBloc.state,
            readProfilePhotoURLState: readProfilePhotoURLBloc.state,
            socialCommentsState: socialCommentsBloc.state,
            listMembersState: listMembersBloc.state,
            urlPostState: urlPostBloc.state,
            shareStringState: shareStringBloc.state,
            fileUploadState: fileUploadBloc.state,
            hashtagsState: hashtagsBloc.state,
            mentionsState: mentionsBloc.state,
            profileState: profileBloc.state,
            shortUrlState: shortUrlBloc.state,
            socialSpacesState: socialSpacesBloc.state,
            socialProfileState: socialProfilesBloc.state,
            socialCreatePostState: socialCreatePostBloc.state,
            socialCurrentProfileState: socialCurrentProfileBloc.state,
            socialPostLikesState: socialPostLikesBloc.state,
            socialLikeState: socialLikeBloc.state,
          ),
        ) {
    on<ChangeAuthorizationStateEvent>(_changeAuthorizationStateEvent);
    on<ChangeSocialFeedStateEvent>(_changeSocialFeedStateEvent);
    on<ChangeConnectivityStateEvent>(_changeConnectivityStateEvent);
    on<ChangeReadProfilePhotoURLStateEvent>(_changeReadProfilePhotoURLStateEvent);
    on<ChangeSocialCommentsStateEvent>(_changeSocialCommentsStateEvent);
    on<ChangeSocialListMembersStateEvent>(_changeSocialListMembersStateEvent);
    on<ChangeGetURLPostStateEvent>(_changeGetURLPostStateEvent);
    on<ChangeShareStringStateEvent>(_changeShareStringStateEvent);
    on<ChangeSocialGetFileUploadStateEvent>(_changeGetFileUploadStateEvent);
    on<ChangeHashtagsStateEvent>(_changeHashtagsStateEvent);
    on<ChangeMentionsStateEvent>(_changeMentionsStateEvent);
    on<ChangeProfileStateEvent>(_changeProfileStateEvent);
    on<ChangeShortUrlStateEvent>(_changeShortUrlStateEvent);
    on<ChangeSocialSpacesStateEvent>(_changeSocialSpacesStateEvent);
    on<ChangeSocialProfilesStateEvent>(_changeSocialProfileStateEvent);
    on<ChangeSocialCreatePostStateEvent>(_changeSocialCreatePostStateEvent);
    on<ChangeSocialCurrentProfileStateEvent>(_changeSocialCurrentProfileStateEvent);
    on<ChangeSocialPostLikeStateEvent>(_changeSocialPostLikesStateEvent);
    on<ChangeSocialLikeStateEvent>(_changeSocialLikeStateEvent);

    connectivitySubscription = connectivityBloc.stream.listen(
      (connectivityState) {
        add(
          ChangeConnectivityStateEvent(
            connectivityState: connectivityState,
          ),
        );
      },
    );

    authorizationSubscription = authorizationBloc.stream.listen((authorizationState) {
      add(
        ChangeAuthorizationStateEvent(
          authorizationState: authorizationState,
        ),
      );
    });

    socialFeedSubscription = socialFeedBloc.stream.listen((socialFeedState) {
      add(
        ChangeSocialFeedStateEvent(
          socialFeedState: socialFeedState,
        ),
      );
    });

    readProfilePhotoSubscription = readProfilePhotoURLBloc.stream.listen((readProfilePhotoURLState) {
      add(
        ChangeReadProfilePhotoURLStateEvent(
          readProfilePhotoURLState: readProfilePhotoURLState,
        ),
      );
    });

    socialCommentsSubscription = socialCommentsBloc.stream.listen((socialCommentsState) {
      add(
        ChangeSocialCommentsStateEvent(
          socialCommentsState: socialCommentsState,
        ),
      );
    });

    listMembersSubscription = listMembersBloc.stream.listen((listMembers) {
      add(
        ChangeSocialListMembersStateEvent(
          socialListMembersState: listMembers,
        ),
      );
    });

    urlPostSubscription = urlPostBloc.stream.listen((urlPost) {
      add(
        ChangeGetURLPostStateEvent(
          urlPostState: urlPost,
        ),
      );
    });

    shareStringSubscription = shareStringBloc.stream.listen((shareString) {
      add(
        ChangeShareStringStateEvent(
          shareStringState: shareString,
        ),
      );
    });

    fileUploadSubscription = fileUploadBloc.stream.listen((fileUploadState) {
      add(
        ChangeSocialGetFileUploadStateEvent(
          fileUploadState: fileUploadState,
        ),
      );
    });

    hashtagsSubscription = hashtagsBloc.stream.listen((hashtags) {
      add(
        ChangeHashtagsStateEvent(
          hashtagsState: hashtags,
        ),
      );
    });

    mentionsSubscription = mentionsBloc.stream.listen((mentions) {
      add(
        ChangeMentionsStateEvent(
          mentionsState: mentions,
        ),
      );
    });

    profileSubscription = profileBloc.stream.listen((profileState) {
      add(
        ChangeProfileStateEvent(
          profileState: profileState,
        ),
      );
    });

    shortUrlSubscription = shortUrlBloc.stream.listen((shortUrlState) {
      add(
        ChangeShortUrlStateEvent(
          shortUrlState: shortUrlState,
        ),
      );
    });

    socialSpacesSubscription = socialSpacesBloc.stream.listen((socialSpacesState) {
      add(
        ChangeSocialSpacesStateEvent(
          socialSpacesState: socialSpacesState,
        ),
      );
    });

    socialProfilesSubscription = socialProfilesBloc.stream.listen((socialProfileState) {
      add(
        ChangeSocialProfilesStateEvent(
          socialProfilesState: socialProfileState,
        ),
      );
    });

    socialCreatePostSubscription = socialCreatePostBloc.stream.listen((socialCreatePostState) {
      add(
        ChangeSocialCreatePostStateEvent(
          socialCreatePostState: socialCreatePostState,
        ),
      );
    });

    socialCurrentProfileSubscription = socialCurrentProfileBloc.stream.listen((socialCurrentProfileState) {
      add(
        ChangeSocialCurrentProfileStateEvent(
          socialCurrentProfileState: socialCurrentProfileState,
        ),
      );
    });

    socialPostLikesSubscription = socialPostLikesBloc.stream.listen((socialPostLikesState) {
      add(
        ChangeSocialPostLikeStateEvent(
          socialPostLikesState: socialPostLikesState,
        ),
      );
    });

    socialLikeSubscription = socialLikeBloc.stream.listen((socialLikeState) {
      add(
        ChangeSocialLikeStateEvent(
          socialLikeState: socialLikeState,
        ),
      );
    });
  }

  Future<void> _changeShortUrlStateEvent(
    ChangeShortUrlStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        shortUrlState: event.shortUrlState,
      ),
    );
  }

  Future<void> _changeAuthorizationStateEvent(
    ChangeAuthorizationStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authorizationState: event.authorizationState,
      ),
    );
  }

  Future<void> _changeSocialFeedStateEvent(
    ChangeSocialFeedStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialFeedState: event.socialFeedState,
      ),
    );
  }

  Future<void> _changeConnectivityStateEvent(
    ChangeConnectivityStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        connectivityState: event.connectivityState,
      ),
    );
  }

  Future<void> _changeSocialCommentsStateEvent(
    ChangeSocialCommentsStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialCommentsState: event.socialCommentsState,
      ),
    );
  }

  Future<void> _changeReadProfilePhotoURLStateEvent(
    ChangeReadProfilePhotoURLStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        readProfilePhotoURLState: event.readProfilePhotoURLState,
      ),
    );
  }

  Future<void> _changeSocialListMembersStateEvent(
    ChangeSocialListMembersStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        listMembersState: event.socialListMembersState,
      ),
    );
  }

  Future<void> _changeGetURLPostStateEvent(
    ChangeGetURLPostStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        urlPostState: event.urlPostState,
      ),
    );
  }

  Future<void> _changeShareStringStateEvent(
    ChangeShareStringStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        shareStringState: event.shareStringState,
      ),
    );
  }

  Future<void> _changeGetFileUploadStateEvent(
    ChangeSocialGetFileUploadStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        fileUploadState: event.fileUploadState,
      ),
    );
  }

  Future<void> _changeHashtagsStateEvent(
    ChangeHashtagsStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        hashtagsState: event.hashtagsState,
      ),
    );
  }

  Future<void> _changeMentionsStateEvent(
    ChangeMentionsStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        mentionsState: event.mentionsState,
      ),
    );
  }

  Future<void> _changeProfileStateEvent(
    ChangeProfileStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        profileState: event.profileState,
      ),
    );
  }

  Future<void> _changeSocialSpacesStateEvent(
    ChangeSocialSpacesStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialSpacesState: event.socialSpacesState,
      ),
    );
  }

  Future<void> _changeSocialProfileStateEvent(
    ChangeSocialProfilesStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialProfileState: event.socialProfilesState,
      ),
    );
  }

  Future<void> _changeSocialCreatePostStateEvent(
    ChangeSocialCreatePostStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialCreatePostState: event.socialCreatePostState,
      ),
    );
  }

  Future<void> _changeSocialCurrentProfileStateEvent(
    ChangeSocialCurrentProfileStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialCurrentProfileState: event.socialCurrentProfileState,
      ),
    );
  }

  Future<void> _changeSocialPostLikesStateEvent(
    ChangeSocialPostLikeStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialPostLikesState: event.socialPostLikesState,
      ),
    );
  }

  Future<void> _changeSocialLikeStateEvent(
    ChangeSocialLikeStateEvent event,
    Emitter<SocialScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialLikeState: event.socialLikeState,
      ),
    );
  }

  @override
  Future<void> close() {
    authorizationSubscription.cancel();
    socialFeedSubscription.cancel();
    connectivitySubscription.cancel();
    readProfilePhotoSubscription.cancel();
    socialCommentsSubscription.cancel();
    listMembersSubscription.cancel();
    urlPostSubscription.cancel();
    shareStringSubscription.cancel();
    hashtagsSubscription.cancel();
    mentionsSubscription.cancel();
    profileSubscription.cancel();
    shortUrlSubscription.cancel();
    socialSpacesSubscription.cancel();
    socialProfilesSubscription.cancel();
    socialCreatePostSubscription.cancel();
    socialCurrentProfileSubscription.cancel();
    socialPostLikesSubscription.cancel();
    socialLikeSubscription.cancel();
    return super.close();
  }
}
