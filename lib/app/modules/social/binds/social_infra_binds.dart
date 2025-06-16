import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/create_comment_repository.dart';
import '../domain/repositories/create_post_repository.dart';
import '../domain/repositories/get_comments_repository.dart';
import '../domain/repositories/get_feed_repository.dart';
import '../domain/repositories/get_file_upload_repository.dart';
import '../domain/repositories/get_hashtags_repository.dart';
import '../domain/repositories/get_members_repository.dart';
import '../domain/repositories/get_mentions_repository.dart';
import '../domain/repositories/get_profile_posts_repository.dart';
import '../domain/repositories/get_profiles_that_liked_post_repository.dart';
import '../domain/repositories/get_short_url_repository.dart';
import '../domain/repositories/get_social_current_profile_repository.dart';
import '../domain/repositories/get_social_member_spaces_repository.dart';
import '../domain/repositories/get_social_my_profiles_repository.dart';
import '../domain/repositories/get_social_profile_repository.dart';
import '../domain/repositories/get_social_search_content_respository.dart';
import '../domain/repositories/get_social_search_space_repository.dart';
import '../domain/repositories/get_space_info_repository.dart';
import '../domain/repositories/get_spaces_repository.dart';
import '../domain/repositories/get_url_post_repository.dart';
import '../domain/repositories/read_profile_photo_url_repository.dart';
import '../domain/repositories/save_dont_show_shorten_link_repository.dart';
import '../domain/repositories/set_like_comment_repository.dart';
import '../domain/repositories/set_post_like_repository.dart';
import '../domain/repositories/set_space_membership_repository.dart';
import '../domain/repositories/share_post_for_members_repository.dart';
import '../domain/repositories/show_message_shorten_link_repository.dart';
import '../infra/adapters/social_attachment_entity_adapter.dart';
import '../infra/adapters/social_comments_entity_adapter.dart';
import '../infra/adapters/social_feed_entity_adapter.dart';
import '../infra/adapters/social_group_entity_adapter.dart';
import '../infra/adapters/social_mention_entity_adapter.dart';
import '../infra/adapters/social_post_entity_adapter.dart';
import '../infra/adapters/social_profile_entity_adapter.dart';
import '../infra/adapters/social_response_request_file_upload_entity_adapter.dart';
import '../infra/adapters/social_search_content_entity_adapter.dart';
import '../infra/adapters/social_space_entity_adapter.dart';
import '../infra/adapters/social_space_membership_entity_adapter.dart';
import '../infra/repositories/create_comment_repository_impl.dart';
import '../infra/repositories/create_post_repository_impl.dart';
import '../infra/repositories/get_comments_repository_impl.dart';
import '../infra/repositories/get_feed_repository_impl.dart';
import '../infra/repositories/get_file_upload_repository_impl.dart';
import '../infra/repositories/get_hashtags_repository_impl.dart';
import '../infra/repositories/get_members_repository_impl.dart';
import '../infra/repositories/get_mentions_repository_impl.dart';
import '../infra/repositories/get_profile_posts_repository_impl.dart';
import '../infra/repositories/get_profiles_that_liked_post_repository_impl.dart';
import '../infra/repositories/get_short_url_repository_impl.dart';
import '../infra/repositories/get_social_current_profile_repository_impl.dart';
import '../infra/repositories/get_social_member_spaces_repository_impl.dart';
import '../infra/repositories/get_social_my_profiles_repository_impl.dart';
import '../infra/repositories/get_social_profile_repository_impl.dart';
import '../infra/repositories/get_social_search_content_repository_impl.dart';
import '../infra/repositories/get_social_search_space_repository_impl.dart';
import '../infra/repositories/get_space_info_repository_impl.dart';
import '../infra/repositories/get_spaces_repository_impl.dart';
import '../infra/repositories/get_url_post_repository_impl.dart';
import '../infra/repositories/read_profile_photo_url_repository_impl.dart';
import '../infra/repositories/save_dont_show_shorten_repository_impl.dart';
import '../infra/repositories/set_like_comment_repository_impl.dart';
import '../infra/repositories/set_post_like_repository_impl.dart';
import '../infra/repositories/set_space_membership_repository_impl.dart';
import '../infra/repositories/share_post_for_members_repository_impl.dart';
import '../infra/repositories/show_message_shorten_link_repository_impl.dart';

class SocialInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.factory<GetFeedRepository>(
      (i) {
        return GetFeedRepositoryImpl(
          
          getFeedDatasource: i.get(),
          feedEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<GetProfilePostsRepository>(
      (i) {
        return GetProfilePostsRepositoryImpl(
          getProfilePostsDatasource: i.get(),
          
          postEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<GetCommentsRepository>(
      (i) {
        return GetCommentsRepositoryImpl(
          
          getCommentsDatasource: i.get(),
          commentsEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<ReadProfilePhotoURLRepository>(
      (i) {
        return ReadProfilePhotoURLRepositoryImpl(
          
          readProfilePhotoURLDatasource: i.get(),
        );
      },
    ),

    Bind.factory<SetPostLikeRepository>(
      (i) {
        return SetPostLikeRepositoryImpl(
          
          setPostLikeDatasource: i.get(),
          
        );
      },
    ),

    Bind.factory<SetLikeCommentRepository>(
      (i) {
        return SetLikeCommentRepositoryImpl(
          
          setLikeCommentDatasource: i.get(),
          
        );
      },
    ),

    Bind.factory<GetMembersRepository>(
      (i) {
        return GetMembersRepositoryImpl(
          
          getMembersDatasource: i.get(),
          membersEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<SharePostForMembersRepository>(
      (i) {
        return SharePostForMembersRepositoryImpl(
          
          
          setPostLikeDatasource: i.get(),
        );
      },
    ),

    Bind.factory<GetURLPostRepository>(
      (i) {
        return GetURLPostRepositoryImpl(
          
          getURLPostDatasource: i.get(),
        );
      },
    ),

    Bind.factory<CreateCommentRepository>(
      (i) {
        return CreateCommentRepositoryImpl(
          
          commentsEntityAdapter: i.get(),
          createCommentDatasource: i.get(),
          
          readAttachmentDownloadUrlDatasource: i.get(),
        );
      },
    ),

    Bind.factory<GetFileUploadRepository>(
      (i) {
        return GetFileUploadRepositoryImpl(
          
          fileUploadEntityAdapter: i.get(),
          getFileUploadDatasource: i.get(),
          storages3AmazonawsDatasource: i.get(),
        );
      },
    ),

    Bind.factory<GetHashtagsRepository>(
      (i) {
        return GetHashtagsRepositoryImpl(
          
          getHashtagsDatasource: i.get(),
        );
      },
    ),

    Bind.factory<GetMentionsRepository>(
      (i) {
        return GetMentionsRepositoryImpl(
          
          getMentionsDatasource: i.get(),
          mentionsEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<GetShortUrlRepository>(
      (i) {
        return GetShortUrlRepositoryImpl(
          
          getShortUrlDatasource: i.get(),
        );
      },
    ),

    Bind.factory<SaveDontShowShortenLinkRepository>((i) {
      return SaveDontShowShortenRepositoryImpl(
        
        saveDontShowShortenLinkDriver: i.get(),
      );
    }),

    Bind.factory<ShowMessageShortenLinkRepository>((i) {
      return ShowMessageShortenLinkRepositoryImpl(
        
        showMessageShortenLinkDriver: i.get(),
      );
    }),

    Bind.factory<GetSocialMemberSpacesRepository>((i) {
      return GetSocialMemberSpacesRepositoryImpl(
        
        getSocialMemberSpacesDatasource: i.get(),
        socialSpaceEntityAdapter: i.get(),
      );
    }),

    Bind.factory<GetSocialCurrentProfileRepository>((i) {
      return GetSocialCurrentProfileRepositoryImpl(
        
        getSocialCurrentProfileDatasource: i.get(),
        socialProfileEntityAdapter: i.get(),
      );
    }),

    Bind.factory<GetSocialMyProfilesRepository>((i) {
      return GetSocialMyProfilesRepositoryImpl(
        
        getSocialMyProfilesDatasource: i.get(),
        socialProfileEntityAdapter: i.get(),
      );
    }),

    Bind.factory<CreatePostRepository>((i) {
      return CreatePostRepositoryImpl(
        
        createPostDatasource: i.get(),
        postEntityAdapter: i.get(),
        
      );
    }),

    Bind.factory<GetProfilesThatLikedPostRepository>((i) {
      return GetProfilesThatLikedPostRepositoryImpl(
        getProfilesThatLikedPostDatasource: i.get(),
        
        membersEntityAdapter: i.get(),
      );
    }),

    Bind.factory<GetSocialSearchContentRepository>((i) {
      return GetSocialSearchContentRepositoryImpl(
        
        socialSearchContentDatasource: i.get(),
        socialSearchContentAdapter: i.get(),
      );
    }),

    Bind.factory<GetSpacesRepository>(
      (i) {
        return GetSpacesRepositoryImpl(
          getSpacesDatasource: i.get(),
          
          spaceEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<GetSocialProfileRepository>((i) {
      return GetSocialProfileRepositoryImpl(
        
        getSocialProfileDatasource: i.get(),
        socialProfileEntityAdapter: i.get(),
      );
    }),

    Bind.factory<GetSpaceInfoRepository>((i) {
      return GetSpaceInfoRepositoryImpl(
        
        getSpaceInfoDatasource: i.get(),
        socialSpaceEntityAdapter: i.get(),
      );
    }),

    Bind.factory<GetSocialSearchSpaceRepository>((i) {
      return GetSocialSearchSpaceRepositoryImpl(
        
        getSocialSearchSpaceDatasource: i.get(),
        socialSpaceAdapter: i.get(),
      );
    }),

    // Adapters
    Bind.factory<SocialFeedEntityAdapter>(
      (i) {
        return SocialFeedEntityAdapter(
          authorEntityAdapter: i.get(),
          postEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<SocialProfileEntityAdapter>(
      (i) {
        return SocialProfileEntityAdapter();
      },
    ),

    Bind.factory<SocialAttachmentEntityAdapter>(
      (i) {
        return SocialAttachmentEntityAdapter();
      },
    ),

    Bind.factory<SocialCommentsEntityAdapter>(
      (i) {
        return SocialCommentsEntityAdapter();
      },
    ),

    Bind.factory<SocialGroupEntityAdapter>(
      (i) {
        return SocialGroupEntityAdapter();
      },
    ),

    Bind.factory<SocialMentionEntityAdapter>(
      (i) {
        return SocialMentionEntityAdapter();
      },
    ),

    Bind.factory<SocialPostEntityAdapter>(
      (i) {
        return SocialPostEntityAdapter(
          authorEntityAdapter: i.get(),
          socialAttachmentEntityAdapter: i.get(),
          socialCommentsEntityAdapter: i.get(),
          socialGroupEntityAdapter: i.get(),
          socialMentionEntityAdapter: i.get(),
          spaceEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<SocialSpaceEntityAdapter>(
      (i) {
        return SocialSpaceEntityAdapter();
      },
    ),

    Bind.factory<SocialResponseRequestFileUploadEntityAdapter>(
      (i) {
        return SocialResponseRequestFileUploadEntityAdapter();
      },
    ),

    Bind.factory<SocialProfileEntityAdapter>(
      (i) {
        return SocialProfileEntityAdapter();
      },
    ),

    Bind.factory<SocialSearchContentEntityAdapter>(
      (i) {
        return SocialSearchContentEntityAdapter(
          socialPostEntityAdapter: i.get(),
          socialProfileEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<SocialSpaceMembershipEntityAdapter>(
      (i) {
        return SocialSpaceMembershipEntityAdapter();
      },
    ),

    Bind.factory<SetSpaceMembershipRepository>(
      (i) {
        return SetSpaceMembershipRepositoryImpl(
          
          setSpaceMembershipDatasource: i.get(),
          socialSpaceMembershipEntityAdapter: i.get(),
        );
      },
    ),
  ];
}
