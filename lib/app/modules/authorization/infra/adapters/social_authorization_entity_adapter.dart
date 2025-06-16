import '../../domain/entities/social_authorization_entity.dart';
import '../../helper/authorization_helper.dart';
import '../models/platform_authorizations_aggregator_model.dart';

class SocialAuthorizationEntityAdapter {
  SocialAuthorizationEntity fromLegacyAndPlatform({
    required PlatformAuthorizationsAggregatorModel platformAuthorizationsAggregatorModel,
  }) {
    bool canViewProfiles = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/profiles',
      action: 'Visualizar',
    );

    bool canViewPosts = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/posts',
      action: 'Visualizar',
    );

    bool canPostLike = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/posts_like',
      action: 'Editar',
    );

    bool canPostComments = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/comments',
      action: 'Editar',
    );

    bool canLikeComments = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/comments_like',
      action: 'Editar',
    );

    bool canEditComments = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/comments_edit',
      action: 'Editar',
    );

    bool canPostFeed = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/posts_feed',
      action: 'Editar',
    );

    bool canAttachmentsPostComments = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/attachments',
      action: 'Visualizar',
    );

    bool canDownloadAttachmentsPostComments = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/attachments',
      action: 'Editar',
    );

    bool canViewSpacesMembers = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/spaces_member',
      action: 'Visualizar',
    );

    bool canCreatePost = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/social/posts',
      action: 'Editar',
    );

    return SocialAuthorizationEntity(
      canViewProfiles: canViewProfiles,
      canViewPosts: canViewPosts,
      canPostLike: canPostLike,
      canPostComments: canPostComments,
      canLikeComments: canLikeComments,
      canEditComments: canEditComments,
      canPostFeed: canPostFeed,
      canAttachmentsPostComments: canAttachmentsPostComments,
      canDownloadAttachmentsPostComments: canDownloadAttachmentsPostComments,
      canViewSpacesMembers: canViewSpacesMembers,
      canCreatePost: canCreatePost,
    );
  }
}
