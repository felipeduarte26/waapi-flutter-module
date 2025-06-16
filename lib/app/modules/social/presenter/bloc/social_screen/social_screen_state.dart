import 'package:equatable/equatable.dart';

import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../home/presenter/bloc/connectivity_bloc/connectivity_state.dart';
import '../../../../profile/presenter/blocs/profile_bloc/profile_state.dart';
import '../get_short_url_bloc/get_short_url_state.dart';
import '../sociaL_post_likes/social_post_likes_state.dart';
import '../social_comments/social_comments_state.dart';
import '../social_create_post/social_create_post_state.dart';
import '../social_current_profile/social_current_profile_state.dart';
import '../social_feed/social_feed_state.dart';
import '../social_files/social_get_file_upload_state.dart';
import '../social_get_url_post/get_url_post_state.dart';
import '../social_hashtags/social_hashtags_state.dart';
import '../social_like_bloc/social_like_state.dart';
import '../social_list_members/social_list_members_state.dart';
import '../social_mentions/social_mentions_state.dart';
import '../social_profile_photo/read_profile_photo_url_state.dart';
import '../social_profiles/social_profiles_state.dart';
import '../social_spaces/social_spaces_state.dart';

abstract class SocialScreenState extends Equatable {
  final AuthorizationState authorizationState;
  final SocialFeedState socialFeedState;
  final ConnectivityState connectivityState;
  final SocialCommentsState socialCommentsState;
  final ReadProfilePhotoURLState readProfilePhotoURLState;
  final SocialListMembersState listMembersState;
  final GetURLPostState urlPostState;
  final AttachmentState shareStringState;
  final SocialGetFileUploadState fileUploadState;
  final SocialHashtagsState hashtagsState;
  final SocialMentionsState mentionsState;
  final ProfileState profileState;
  final GetShortUrlState shortUrlState;
  final SocialSpacesState socialSpacesState;
  final SocialProfilesState socialProfileState;
  final SocialCreatePostState socialCreatePostState;
  final SocialCurrentProfileState socialCurrentProfileState;
  final SocialPostLikesState socialPostLikesState;
  final SocialLikeState socialLikeState;

  const SocialScreenState({
    required this.authorizationState,
    required this.socialFeedState,
    required this.connectivityState,
    required this.readProfilePhotoURLState,
    required this.socialCommentsState,
    required this.listMembersState,
    required this.urlPostState,
    required this.shareStringState,
    required this.fileUploadState,
    required this.hashtagsState,
    required this.mentionsState,
    required this.profileState,
    required this.shortUrlState,
    required this.socialSpacesState,
    required this.socialProfileState,
    required this.socialCreatePostState,
    required this.socialCurrentProfileState,
    required this.socialPostLikesState,
    required this.socialLikeState,
  });

  CurrentSocialScreenState currentState({
    AuthorizationState? authorizationState,
    SocialFeedState? socialFeedState,
    final ConnectivityState? connectivityState,
    SocialCommentsState? socialCommentsState,
    ReadProfilePhotoURLState? readProfilePhotoURLState,
    SocialListMembersState? listMembersState,
    GetURLPostState? urlPostState,
    AttachmentState? shareStringState,
    SocialGetFileUploadState? fileUploadState,
    SocialHashtagsState? hashtagsState,
    SocialMentionsState? mentionsState,
    ProfileState? profileState,
    GetShortUrlState? shortUrlState,
    SocialSpacesState? socialSpacesState,
    SocialProfilesState? socialProfileState,
    SocialCreatePostState? socialCreatePostState,
    SocialCurrentProfileState? socialCurrentProfileState,
    SocialPostLikesState? socialPostLikesState,
    SocialLikeState? socialLikeState,
  }) {
    return CurrentSocialScreenState(
      authorizationState: authorizationState ?? this.authorizationState,
      socialFeedState: socialFeedState ?? this.socialFeedState,
      connectivityState: connectivityState ?? this.connectivityState,
      readProfilePhotoURLState: readProfilePhotoURLState ?? this.readProfilePhotoURLState,
      socialCommentsState: socialCommentsState ?? this.socialCommentsState,
      listMembersState: listMembersState ?? this.listMembersState,
      urlPostState: urlPostState ?? this.urlPostState,
      shareStringState: shareStringState ?? this.shareStringState,
      fileUploadState: fileUploadState ?? this.fileUploadState,
      hashtagsState: hashtagsState ?? this.hashtagsState,
      mentionsState: mentionsState ?? this.mentionsState,
      profileState: profileState ?? this.profileState,
      shortUrlState: shortUrlState ?? this.shortUrlState,
      socialSpacesState: socialSpacesState ?? this.socialSpacesState,
      socialProfileState: socialProfileState ?? this.socialProfileState,
      socialCreatePostState: socialCreatePostState ?? this.socialCreatePostState,
      socialCurrentProfileState: socialCurrentProfileState ?? this.socialCurrentProfileState,
      socialPostLikesState: socialPostLikesState ?? this.socialPostLikesState,
      socialLikeState: socialLikeState ?? this.socialLikeState,
    );
  }

  @override
  List<Object> get props => [
        authorizationState,
        socialFeedState,
        connectivityState,
        readProfilePhotoURLState,
        socialCommentsState,
        listMembersState,
        urlPostState,
        shareStringState,
        fileUploadState,
        hashtagsState,
        mentionsState,
        profileState,
        shortUrlState,
        socialSpacesState,
        socialProfileState,
        socialCreatePostState,
        socialCurrentProfileState,
        socialLikeState,
      ];
}

class CurrentSocialScreenState extends SocialScreenState {
  const CurrentSocialScreenState({
    required super.authorizationState,
    required super.socialFeedState,
    required super.connectivityState,
    required super.readProfilePhotoURLState,
    required super.socialCommentsState,
    required super.listMembersState,
    required super.urlPostState,
    required super.shareStringState,
    required super.fileUploadState,
    required super.hashtagsState,
    required super.mentionsState,
    required super.profileState,
    required super.shortUrlState,
    required super.socialSpacesState,
    required super.socialProfileState,
    required super.socialCreatePostState,
    required super.socialCurrentProfileState,
    required super.socialPostLikesState,
    required super.socialLikeState,
  });
}
