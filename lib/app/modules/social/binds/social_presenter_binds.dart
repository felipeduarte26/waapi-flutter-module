import 'package:flutter_modular/flutter_modular.dart';
import 'package:uuid/uuid.dart';

import '../../../core/services/file/file_image_service.dart';
import '../presenter/bloc/get_short_url_bloc/get_short_url_bloc.dart';
import '../presenter/bloc/sociaL_post_likes/social_post_likes_bloc.dart';
import '../presenter/bloc/social_comments/social_comments_bloc.dart';
import '../presenter/bloc/social_create_post/social_create_post_bloc.dart';
import '../presenter/bloc/social_current_profile/social_current_profile_bloc.dart';
import '../presenter/bloc/social_feed/social_feed_bloc.dart';
import '../presenter/bloc/social_files/social_get_file_upload_bloc.dart';
import '../presenter/bloc/social_get_url_post/get_url_post_bloc.dart';
import '../presenter/bloc/social_hashtags/social_hashtags_bloc.dart';
import '../presenter/bloc/social_like_bloc/social_like_bloc.dart';
import '../presenter/bloc/social_list_members/social_list_members_bloc.dart';
import '../presenter/bloc/social_mentions/social_mentions_bloc.dart';
import '../presenter/bloc/social_profile_photo/read_profile_photo_url_bloc.dart';
import '../presenter/bloc/social_profile_posts/social_profile_posts_bloc.dart';
import '../presenter/bloc/social_profiles/social_profiles_bloc.dart';
import '../presenter/bloc/social_screen/social_screen_bloc.dart';
import '../presenter/bloc/social_search/social_search_bloc.dart';
import '../presenter/bloc/social_space_feed/social_space_feed_bloc.dart';
import '../presenter/bloc/social_space_info/social_space_info_bloc.dart';
import '../presenter/bloc/social_space_list/social_space_list_bloc.dart';
import '../presenter/bloc/social_space_membership/social_space_membership_bloc.dart';
import '../presenter/bloc/social_spaces/social_spaces_bloc.dart';
import '../presenter/bloc/social_tag_feed/social_tag_feed_bloc.dart';
import '../presenter/screen/social_search/bloc/social_search_screen_bloc.dart';

class SocialPresenterBinds {
  static List<Bind<Object>> binds = [
    //Blocs
    Bind.lazySingleton<SocialFeedBloc>(
      (i) => SocialFeedBloc(
        getFeedUsecase: i.get(),
        sharePostForMemberUsecase: i.get(),
      ),
    ),

    Bind.factory<SocialTagFeedBloc>(
      (i) => SocialTagFeedBloc(
        getFeedUsecase: i.get(),
      ),
    ),

    Bind.lazySingleton<SocialCommentsBloc>(
      (i) {
        return SocialCommentsBloc(
          getCommentsUsecase: i.get(),
          setLikeCommentUsecase: i.get(),
          createCommentUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton<SocialGetFileUploadBloc>(
      (i) {
        return SocialGetFileUploadBloc(
          uuid: const Uuid(),
          getFileUploadUsecase: i.get(),
          fileImageService: FileImageService(
            imageDecoder: ImageDecoder(),
          ),
        );
      },
    ),

    Bind.factory<SocialListMembersBloc>(
      (i) {
        return SocialListMembersBloc(
          getListMembersUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton<ReadProfilePhotoURLBloc>(
      (i) {
        return ReadProfilePhotoURLBloc(
          readProfilePhotoURLUsecase: i.get(),
        );
      },
    ),

    Bind.factory<GetURLPostBloc>(
      (i) {
        return GetURLPostBloc(
          getURLPostUsecase: i.get(),
        );
      },
    ),

    Bind.factory<GetShortUrlBloc>(
      (i) {
        return GetShortUrlBloc(
          getShortUrlUsecase: i.get(),
          saveDontShowMessageShortenLinkUsecase: i.get(),
          showMessageShortenLinkUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton<SocialScreenBloc>(
      (i) {
        return SocialScreenBloc(
          authorizationBloc: i.get(),
          socialFeedBloc: i.get(),
          connectivityBloc: i.get(),
          socialCommentsBloc: i.get(),
          readProfilePhotoURLBloc: i.get(),
          listMembersBloc: i.get(),
          urlPostBloc: i.get(),
          shareStringBloc: i.get(),
          fileUploadBloc: i.get(),
          hashtagsBloc: i.get(),
          mentionsBloc: i.get(),
          profileBloc: i.get(),
          shortUrlBloc: i.get(),
          socialSpacesBloc: i.get(),
          socialProfilesBloc: i.get(),
          socialCreatePostBloc: i.get(),
          socialCurrentProfileBloc: i.get(),
          socialPostLikesBloc: i.get(),
          socialLikeBloc: i.get(),
        );
      },
    ),

    Bind.factory<SocialHashtagsBloc>(
      (i) {
        return SocialHashtagsBloc(
          getHashtagsUsecase: i.get(),
        );
      },
    ),

    Bind.factory<SocialMentionsBloc>(
      (i) {
        return SocialMentionsBloc(
          getMentionsUsecase: i.get(),
        );
      },
    ),

    Bind.factory<SocialSpacesBloc>(
      (i) {
        return SocialSpacesBloc(
          getSocialMembersSpaceUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton<SocialProfilesBloc>(
      (i) {
        return SocialProfilesBloc(
          getSocialMyProfilesUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton<SocialCurrentProfileBloc>(
      (i) {
        return SocialCurrentProfileBloc(
          getSocialCurrentProfileUsecase: i.get(),
        );
      },
    ),

    Bind.factory<SocialCreatePostBloc>(
      (i) {
        return SocialCreatePostBloc(
          socialCreatePostUseCase: i.get(),
        );
      },
    ),

    Bind.lazySingleton<SocialPostLikesBloc>(
      (i) {
        return SocialPostLikesBloc(
          getProfilesThatLikedPostUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton<SocialSpaceListBloc>(
      (i) {
        return SocialSpaceListBloc(
          getSpacesUsecase: i.get(),
        );
      },
    ),

    Bind.factory<SocialSpaceInfoBloc>(
      (i) {
        return SocialSpaceInfoBloc(
          getSocialSpaceInfoUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton<SocialSearchBloc>(
      (i) {
        return SocialSearchBloc(
          getSocialSearchResultUsecase: i.get(),
          getSocialSearchSpaceUsecase: i.get(),
        );
      },
    ),

    Bind.factory<SocialSearchScreenBloc>(
      (i) {
        return SocialSearchScreenBloc(
          socialSearchBloc: i.get(),
          socialSpaceInfoBloc: i.get(),
        );
      },
    ),

    Bind.factory<SocialSpaceMembershipBloc>(
      (i) {
        return SocialSpaceMembershipBloc(
          setSpaceMembershipUsecase: i.get(),
        );
      },
    ),

    Bind.factory<SocialProfilePostsBloc>(
      (i) {
        return SocialProfilePostsBloc(
          getProfilePostsUsecase: i.get(),
          getSocialProfileUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton<SocialLikeBloc>(
      (i) {
        return SocialLikeBloc(
          setPostLikeUsecase: i.get(),
        );
      },
    ),

    Bind.factory<SocialSpaceFeedBloc>(
      (i) {
        return SocialSpaceFeedBloc(
          getFeedUsecase: i.get(),
          getSpaceInfoUsecase: i.get(),
        );
      },
    ),
  ];
}
