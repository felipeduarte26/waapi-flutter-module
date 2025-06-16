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

abstract class SocialScreenEvent extends Equatable {}

class ChangeAuthorizationStateEvent extends SocialScreenEvent {
  final AuthorizationState authorizationState;

  ChangeAuthorizationStateEvent({
    required this.authorizationState,
  });

  @override
  List<Object?> get props {
    return [
      authorizationState,
    ];
  }
}

class ChangeSocialFeedStateEvent extends SocialScreenEvent {
  final SocialFeedState socialFeedState;

  ChangeSocialFeedStateEvent({
    required this.socialFeedState,
  });

  @override
  List<Object?> get props {
    return [
      socialFeedState,
    ];
  }
}

class ChangeConnectivityStateEvent extends SocialScreenEvent {
  final ConnectivityState connectivityState;

  ChangeConnectivityStateEvent({
    required this.connectivityState,
  });

  @override
  List<Object?> get props {
    return [
      connectivityState,
    ];
  }
}

class ChangeSocialCommentsStateEvent extends SocialScreenEvent {
  final SocialCommentsState socialCommentsState;

  ChangeSocialCommentsStateEvent({
    required this.socialCommentsState,
  });

  @override
  List<Object?> get props {
    return [
      socialCommentsState,
    ];
  }
}

class ChangeReadProfilePhotoURLStateEvent extends SocialScreenEvent {
  final ReadProfilePhotoURLState readProfilePhotoURLState;

  ChangeReadProfilePhotoURLStateEvent({
    required this.readProfilePhotoURLState,
  });

  @override
  List<Object?> get props {
    return [
      readProfilePhotoURLState,
    ];
  }
}

class ChangeSocialListMembersStateEvent extends SocialScreenEvent {
  final SocialListMembersState socialListMembersState;

  ChangeSocialListMembersStateEvent({
    required this.socialListMembersState,
  });

  @override
  List<Object?> get props {
    return [
      socialListMembersState,
    ];
  }
}

class ChangeGetURLPostStateEvent extends SocialScreenEvent {
  final GetURLPostState urlPostState;

  ChangeGetURLPostStateEvent({
    required this.urlPostState,
  });

  @override
  List<Object?> get props {
    return [
      urlPostState,
    ];
  }
}

class ChangeShareStringStateEvent extends SocialScreenEvent {
  final AttachmentState shareStringState;

  ChangeShareStringStateEvent({
    required this.shareStringState,
  });

  @override
  List<Object?> get props {
    return [
      shareStringState,
    ];
  }
}

class ChangeSocialGetFileUploadStateEvent extends SocialScreenEvent {
  final SocialGetFileUploadState fileUploadState;

  ChangeSocialGetFileUploadStateEvent({
    required this.fileUploadState,
  });

  @override
  List<Object?> get props {
    return [
      fileUploadState,
    ];
  }
}

class ChangeHashtagsStateEvent extends SocialScreenEvent {
  final SocialHashtagsState hashtagsState;

  ChangeHashtagsStateEvent({
    required this.hashtagsState,
  });

  @override
  List<Object?> get props {
    return [
      hashtagsState,
    ];
  }
}

class ChangeMentionsStateEvent extends SocialScreenEvent {
  final SocialMentionsState mentionsState;

  ChangeMentionsStateEvent({
    required this.mentionsState,
  });

  @override
  List<Object?> get props {
    return [
      mentionsState,
    ];
  }
}

class ChangeProfileStateEvent extends SocialScreenEvent {
  final ProfileState profileState;

  ChangeProfileStateEvent({
    required this.profileState,
  });

  @override
  List<Object?> get props {
    return [
      profileState,
    ];
  }
}

class ChangeShortUrlStateEvent extends SocialScreenEvent {
  final GetShortUrlState shortUrlState;

  ChangeShortUrlStateEvent({
    required this.shortUrlState,
  });

  @override
  List<Object?> get props {
    return [
      shortUrlState,
    ];
  }
}

class ChangeSocialSpacesStateEvent extends SocialScreenEvent {
  final SocialSpacesState socialSpacesState;

  ChangeSocialSpacesStateEvent({
    required this.socialSpacesState,
  });

  @override
  List<Object?> get props {
    return [
      socialSpacesState,
    ];
  }
}

class ChangeSocialProfilesStateEvent extends SocialScreenEvent {
  final SocialProfilesState socialProfilesState;

  ChangeSocialProfilesStateEvent({
    required this.socialProfilesState,
  });

  @override
  List<Object?> get props {
    return [
      socialProfilesState,
    ];
  }
}

class ChangeSocialCreatePostStateEvent extends SocialScreenEvent {
  final SocialCreatePostState socialCreatePostState;

  ChangeSocialCreatePostStateEvent({
    required this.socialCreatePostState,
  });

  @override
  List<Object?> get props {
    return [
      socialCreatePostState,
    ];
  }
}

class ChangeSocialCurrentProfileStateEvent extends SocialScreenEvent {
  final SocialCurrentProfileState socialCurrentProfileState;

  ChangeSocialCurrentProfileStateEvent({
    required this.socialCurrentProfileState,
  });

  @override
  List<Object?> get props {
    return [
      socialCurrentProfileState,
    ];
  }
}

class ChangeSocialPostLikeStateEvent extends SocialScreenEvent {
  final SocialPostLikesState socialPostLikesState;

  ChangeSocialPostLikeStateEvent({
    required this.socialPostLikesState,
  });

  @override
  List<Object?> get props {
    return [
      socialPostLikesState,
    ];
  }
}

class ChangeSocialLikeStateEvent extends SocialScreenEvent {
  final SocialLikeState socialLikeState;

  ChangeSocialLikeStateEvent({
    required this.socialLikeState,
  });

  @override
  List<Object?> get props {
    return [
      socialLikeState,
    ];
  }
}
