import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/create_comment_usecase.dart';
import '../domain/usecases/create_post_usecase.dart';
import '../domain/usecases/get_comments_usecase.dart';
import '../domain/usecases/get_feed_usecase.dart';
import '../domain/usecases/get_file_upload_usecase.dart';
import '../domain/usecases/get_hashtags_usecase.dart';
import '../domain/usecases/get_members_usecase.dart';
import '../domain/usecases/get_mentions_usecase.dart';
import '../domain/usecases/get_profile_posts_usecase.dart';
import '../domain/usecases/get_profiles_that_liked_post_usecase.dart';
import '../domain/usecases/get_short_url_usecase.dart';
import '../domain/usecases/get_social_current_profile_usecase.dart';
import '../domain/usecases/get_social_members_space_usecase.dart';
import '../domain/usecases/get_social_my_profiles_usecase.dart';
import '../domain/usecases/get_social_profile_usecase.dart';
import '../domain/usecases/get_social_search_content_usecase.dart';
import '../domain/usecases/get_social_search_space_usecase.dart';
import '../domain/usecases/get_space_info_usecase.dart';
import '../domain/usecases/get_spaces_usecase.dart';
import '../domain/usecases/get_url_post_usecase.dart';
import '../domain/usecases/read_profile_photo_url_usecase.dart';
import '../domain/usecases/save_dont_show_shorten_link_usercase.dart';
import '../domain/usecases/set_like_comment_usecase.dart';
import '../domain/usecases/set_post_like_usecase.dart';
import '../domain/usecases/set_space_membership_usecase.dart';
import '../domain/usecases/share_post_for_members_usecase.dart';
import '../domain/usecases/show_message_shorten_link_usecase.dart';

class SocialDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.factory<GetFeedUsecase>((i) {
      return GetFeedUsecaseImpl(
        getFeedRepository: i.get(),
      );
    }),

    Bind.factory<GetProfilePostsUsecase>(
      (i) {
        return GetProfilePostsUsecaseImpl(
          getProfilePostsRepository: i.get(),
        );
      },
    ),

    Bind.factory<GetCommentsUsecase>((i) {
      return GetCommentsUsecaseImpl(
        getCommentsRepository: i.get(),
      );
    }),

    Bind.factory<ReadProfilePhotoURLUsecase>((i) {
      return ReadProfilePhotoURLUsecaseImpl(
        readProfilePhotoURLRepository: i.get(),
      );
    }),

    Bind.factory<SetPostLikeUsecase>((i) {
      return SetPostLikeUsecaseImpl(
        setPostLikeRepository: i.get(),
      );
    }),

    Bind.factory<SetLikeCommentUsecase>((i) {
      return SetLikeCommentUsecaseImpl(
        setLikeCommentRepository: i.get(),
      );
    }),

    Bind.factory<GetMembersUsecase>((i) {
      return GetMembersUsecaseImpl(
        getMembersRepository: i.get(),
      );
    }),

    Bind.factory<SharePostForMembersUsecase>((i) {
      return SharePostForMembersUsecaseImpl(
        sharePostForMemberRepository: i.get(),
      );
    }),

    Bind.factory<GetURLPostUsecase>((i) {
      return GetURLPostUsecaseImpl(
        getURLPostRepository: i.get(),
      );
    }),

    Bind.factory<CreateCommentUsecase>((i) {
      return CreateCommentUsecaseImpl(
        createCommentRepository: i.get(),
      );
    }),

    Bind.factory<GetFileUploadUsecase>((i) {
      return GetFileUploadUsecaseImpl(
        getFileUploadRepository: i.get(),
      );
    }),

    Bind.factory<GetHashtagsUsecase>((i) {
      return GetHashtagsUsecaseImpl(
        getHashtagsRepository: i.get(),
      );
    }),

    Bind.factory<GetMentionsUsecase>((i) {
      return GetMentionsUsecaseImpl(
        getMentionsRepository: i.get(),
      );
    }),

    Bind.factory<GetShortUrlUsecase>((i) {
      return GetShortUrlUsecaseImpl(
        getShortUrlRepository: i.get(),
      );
    }),

    Bind.factory<SaveDontShowShortenLinkUsercase>((i) {
      return SaveDontShowShortenLinkUsercaseImpl(
        saveDontShowShortenLinkRepository: i.get(),
      );
    }),

    Bind.factory<ShowMessageShortenLinkUsecase>((i) {
      return ShowMessageShortenLinkUsecaseImpl(
        showMessageShortenLinkRepository: i.get(),
      );
    }),

    Bind.factory<GetSocialMembersSpaceUsecase>((i) {
      return GetSocialMembersSpaceUsecaseImpl(
        getMembersSpaceRepository: i.get(),
      );
    }),

    Bind.factory<GetSocialCurrentProfileUsecase>((i) {
      return GetSocialCurrentProfileUseCaseImpl(
        getSocialCurrentProfileRepository: i.get(),
      );
    }),

    Bind.factory<GetSocialMyProfilesUsecase>((i) {
      return GetSocialMyProfilesUsecaseImpl(
        getSocialMyProfilesRepository: i.get(),
      );
    }),

    Bind.factory<CreatePostUsecase>((i) {
      return CreatePostUsecaseImpl(
        createPostRepository: i.get(),
      );
    }),

    Bind.factory<GetProfilesThatLikedPostUsecase>((i) {
      return GetProfilesThatLikedPostUsecaseImpl(
        getProfilesThatLikedPostRepository: i.get(),
      );
    }),

    Bind.factory<GetSocialProfileUsecase>((i) {
      return GetSocialProfileUsecaseImpl(
        getSocialProfileRepository: i.get(),
      );
    }),

    Bind.factory<GetSocialSearchContentUsecase>((i) {
      return GetSocialSearchContentUsecaseImpl(
        socialSearchContentRepository: i.get(),
      );
    }),

    Bind.factory<GetSpacesUsecase>(
      (i) {
        return GetSpacesUsecaseImpl(
          getSpacesRepository: i.get(),
        );
      },
    ),

    Bind.factory<GetSpaceInfoUsecase>((i) {
      return GetSpaceInfoUsecaseImpl(
        getSpaceInfoRepository: i.get(),
      );
    }),

    Bind.factory<SetSpaceMembershipUsecase>(
      (i) {
        return SetSpaceMembershipUsecaseImpl(
          setSpaceMembershipRepository: i.get(),
        );
      },
    ),

    Bind.factory<GetSocialSearchSpaceUsecase>((i) {
      return GetSocialSearchSpaceUsecaseImpl(
        socialSearchSpaceRepository: i.get(),
      );
    }),
  ];
}
