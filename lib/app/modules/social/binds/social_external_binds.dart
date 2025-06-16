import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../external/datasource/create_comment_datasource_impl.dart';
import '../external/datasource/create_post_datasource_impl.dart';
import '../external/datasource/get_comments_datasource_impl.dart';
import '../external/datasource/get_feed_datasource_impl.dart';
import '../external/datasource/get_file_upload_datasource_impl.dart';
import '../external/datasource/get_hashtags_datasource_impl.dart';
import '../external/datasource/get_members_datasource_impl.dart';
import '../external/datasource/get_mentions_datasource_impl.dart';
import '../external/datasource/get_profile_posts_datasource_impl.dart';
import '../external/datasource/get_profiles_that_liked_post_datasource_impl.dart';
import '../external/datasource/get_short_url_datasource_impl.dart';
import '../external/datasource/get_social_current_profile_datasource_impl.dart';
import '../external/datasource/get_social_members_space_datasource_impl.dart';
import '../external/datasource/get_social_my_profiles_datasource_impl.dart';
import '../external/datasource/get_social_profile_datasource_impl.dart';
import '../external/datasource/get_social_search_content_datasource_impl.dart';
import '../external/datasource/get_social_search_space_datasource_impl.dart';
import '../external/datasource/get_space_info_datasource_impl.dart';
import '../external/datasource/get_spaces_datasource_impl.dart';
import '../external/datasource/get_url_post_datasource_impl.dart';
import '../external/datasource/read_attachment_download_url_datasource_impl.dart';
import '../external/datasource/read_profile_photo_url_datasource_impl.dart';
import '../external/datasource/set_like_comment_datasource_impl.dart';
import '../external/datasource/set_post_like_datasource_impl.dart';
import '../external/datasource/set_space_membership_datasource_impl.dart';
import '../external/datasource/share_post_for_member_datasource_impl.dart';
import '../external/datasource/storages3_amazonaws_datasource_impl.dart';
import '../external/drivers/save_dont_show_shorten_link_driver_impl.dart';
import '../external/drivers/show_message_shorten_link_driver_impl.dart';
import '../external/mappers/social_attachment_input_model_mapper.dart';
import '../external/mappers/social_comments_model_mapper.dart';
import '../external/mappers/social_create_comment_inptut_model_mapper.dart';
import '../external/mappers/social_create_post_input_model_mapper.dart';
import '../external/mappers/social_feed_model_mapper.dart';
import '../external/mappers/social_post_model_list_mapper.dart';
import '../external/mappers/social_post_model_mapper.dart';
import '../external/mappers/social_profile_model_mapper.dart';
import '../external/mappers/social_search_content_model_mapper.dart';
import '../external/mappers/social_space_membership_model_mapper.dart';
import '../external/mappers/social_space_model_list_mapper.dart';
import '../external/mappers/social_space_model_mapper.dart';
import '../external/mappers/storages3_aws_upload_intput_model_mapper.dart';
import '../infra/datasources/create_comment_datasource.dart';
import '../infra/datasources/create_post_datasource.dart';
import '../infra/datasources/get_comments_datasource.dart';
import '../infra/datasources/get_feed_datasource.dart';
import '../infra/datasources/get_file_upload_datasource.dart';
import '../infra/datasources/get_hashtags_datasource.dart';
import '../infra/datasources/get_members_datasource.dart';
import '../infra/datasources/get_mentions_datasource.dart';
import '../infra/datasources/get_profile_posts_datasource.dart';
import '../infra/datasources/get_profiles_that_liked_post_datasource.dart';
import '../infra/datasources/get_short_url_datasource.dart';
import '../infra/datasources/get_social_current_profile_datasource.dart';
import '../infra/datasources/get_social_members_space_datasource.dart';
import '../infra/datasources/get_social_my_profiles_datasource.dart';
import '../infra/datasources/get_social_profile_datasource.dart';
import '../infra/datasources/get_social_search_content_datasource.dart';
import '../infra/datasources/get_social_search_space_datasource.dart';
import '../infra/datasources/get_space_info_datasource.dart';
import '../infra/datasources/get_spaces_datasource.dart';
import '../infra/datasources/get_url_post_datasource.dart';
import '../infra/datasources/read_attachment_download_url_datasource.dart';
import '../infra/datasources/read_profile_photo_url_datasource.dart';
import '../infra/datasources/set_like_comment_datasource.dart';
import '../infra/datasources/set_post_like_datasource.dart';
import '../infra/datasources/set_space_membership_datasource.dart';
import '../infra/datasources/share_post_for_member_datasource.dart';
import '../infra/datasources/storages3_amazonaws_datasource.dart';
import '../infra/drivers/save_dont_show_shorten_link_driver.dart';
import '../infra/drivers/show_message_shorten_link_driver.dart';

class SocialExternalBinds {
  static List<Bind<Object>> binds = [
    //Datasource
    Bind.factory<GetFeedDatasource>(
      (i) {
        return GetFeedDatasourceImpl(
          restService: i.get(),
          feedMapper: i.get(),
        );
      },
    ),

    Bind.factory<GetProfilePostsDatasource>(
      (i) {
        return GetProfilePostsDatasourceImpl(
          restService: i.get(),
          postMapper: i.get(),
        );
      },
    ),

    Bind.factory<GetCommentsDatasource>(
      (i) {
        return GetCommentsDatasourceImpl(
          restService: i.get(),
          commentsMapper: i.get(),
        );
      },
    ),

    Bind.factory<ReadProfilePhotoURLDatasource>(
      (i) {
        return ReadProfilePhotoURLDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    Bind.factory<SetPostLikeDatasource>(
      (i) {
        return SetPostLikeDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    Bind.factory<SetLikeCommentDatasource>(
      (i) {
        return SetLikeCommentDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    Bind.factory<GetMembersDatasource>(
      (i) {
        return GetMembersDatasourceImpl(
          restService: i.get(),
          membersMapper: i.get(),
        );
      },
    ),

    Bind.factory<SharePostForMemberDatasource>(
      (i) {
        return SharePostForMemberDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    Bind.factory<GetURLPostDatasource>(
      (i) {
        return GetURLPostDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    Bind.factory<CreateCommentDatasource>(
      (i) {
        return CreateCommentDatasourceImpl(
          restService: i.get(),
          commentsMapper: i.get(),
          socialCreateCommentInptutModelMapper: i.get(),
        );
      },
    ),

    Bind.factory<GetFileUploadDatasource>((i) {
      return GetFileUploadDatasourceImpl(
        restService: i.get(),
        fileUploadMapper: i.get(),
      );
    }),

    Bind.factory<Storages3AmazonawsDatasource>((i) {
      return Storages3AmazonawsDatasourceImpl(
        httpClient: http.Client(),
      );
    }),

    Bind.factory<GetHashtagsDatasource>(
      (i) {
        return GetHashtagsDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    Bind.factory<ReadAttachmentDownloadUrlDatasource>(
      (i) {
        return ReadAttachmentDownloadUrlDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    Bind.factory<GetMentionsDatasource>(
      (i) {
        return GetMentionsDatasourceImpl(
          restService: i.get(),
          mentionsMapper: i.get(),
        );
      },
    ),

    Bind.factory<GetShortUrlDatasource>((i) {
      return GetShortUrlDatasourceImpl(
        restService: i.get(),
      );
    }),


    Bind.factory<GetSocialSearchSpaceDatasource>((i) {
      return GetSocialSearchSpaceDatasourceImpl(
        restService: i.get(),
        socialSpaceModelMapper: i.get(),
      );
    }),

    Bind.factory<SaveDontShowShortenLinkDriver>((i) {
      return SaveDontShowShortenLinkDriverImpl(
        internalStorageService: i.get(),
      );
    }),

    Bind.factory<ShowMessageShortenLinkDriver>((i) {
      return ShowMessageShortenLinkDriverImpl(
        internalStorageService: i.get(),
      );
    }),

    Bind.factory<GetSocialMembersSpaceDatasource>((i) {
      return GetSocialMembersSpaceDatasourceImpl(
        restService: i.get(),
        socialSpaceModelMapper: i.get(),
      );
    }),

    Bind.factory<GetSocialCurrentProfileDatasource>((i) {
      return GetSocialCurrentProfileDatasourceImpl(
        restService: i.get(),
        socialProfileModelMapper: i.get(),
      );
    }),

    Bind.factory<GetSocialMyProfilesDatasource>((i) {
      return GetSocialMyProfilesDatasourceImpl(
        restService: i.get(),
        socialProfileModelMapper: i.get(),
      );
    }),

    Bind.factory<CreatePostDatasource>((i) {
      return CreatePostDatasourceImpl(
        restService: i.get(),
        socialCreatePostInputModelMapper: i.get(),
        socialPostModelMapper: i.get(),
      );
    }),

    Bind.factory<GetProfilesThatLikedPostDatasource>((i) {
      return GetProfilesThatLikedPostDatasourceImpl(
        restService: i.get(),
        membersMapper: i.get(),
      );
    }),

    Bind.factory<GetSocialSearchContentDatasource>((i) {
      return GetSocialSearchContentDatasourceImpl(
        restService: i.get(),
        socialSearchContentModelMapper: i.get(),
      );
    }),

    Bind.factory<GetSpacesDatasource>(
      (i) {
        return GetSpacesDatasourceImpl(
          restService: i.get(),
          socialSpaceListMapper: i.get(),
        );
      },
    ),

    Bind.factory<GetSocialProfileDatasource>((i) {
      return GetSocialProfileDatasourceImpl(
        restService: i.get(),
        socialProfileModelMapper: i.get(),
      );
    }),

    Bind.factory<GetSpaceInfoDatasource>((i) {
      return GetSpaceInfoDatasourceImpl(
        restService: i.get(),
        socialSpaceMapper: i.get(),
      );
    }),

    Bind.factory<SetSpaceMembershipDatasource>(
      (i) {
        return SetSpaceMembershipDatasourceImpl(
          restService: i.get(),
          mapper: i.get(),
        );
      },
    ),

    //Mappers
    Bind.factory<SocialFeedModelMapper>(
      (i) {
        return SocialFeedModelMapper();
      },
    ),

    Bind.factory<SocialCommentsModelMapper>(
      (i) {
        return SocialCommentsModelMapper();
      },
    ),

    Bind.factory<SocialProfileModelMapper>(
      (i) {
        return SocialProfileModelMapper();
      },
    ),

    Bind.factory<Storages3AwsUploadModelMapper>(
      (i) {
        return Storages3AwsUploadModelMapper();
      },
    ),

    Bind.factory<SocialtAttachmentInputModelMapper>(
      (i) {
        return SocialtAttachmentInputModelMapper();
      },
    ),

    Bind.factory<SocialCreateCommentInptutModelMapper>(
      (i) {
        return SocialCreateCommentInptutModelMapper();
      },
    ),

    Bind.factory<SocialSpaceModelMapper>(
      (i) {
        return SocialSpaceModelMapper();
      },
    ),

    Bind.factory<SocialProfileModelMapper>(
      (i) {
        return SocialProfileModelMapper();
      },
    ),

    Bind.factory<SocialCreatePostInputModelMapper>(
      (i) {
        return SocialCreatePostInputModelMapper();
      },
    ),

    Bind.factory<SocialPostModelMapper>(
      (i) {
        return SocialPostModelMapper();
      },
    ),

    Bind.factory<SocialSearchContentModelMapper>(
      (i) {
        return SocialSearchContentModelMapper();
      },
    ),

    Bind.factory<SocialSpaceModelListMapper>(
      (i) {
        return SocialSpaceModelListMapper(
          socialSpaceModelMapper: i.get(),
        );
      },
    ),

    Bind.factory<SocialSpaceMembershipModelMapper>(
      (i) {
        return SocialSpaceMembershipModelMapper();
      },
    ),

    Bind.factory<SocialPostModelListMapper>(
      (i) {
        return SocialPostModelListMapper(
          socialPostModelMapper: i.get(),
        );
      },
    ),
  ];
}
