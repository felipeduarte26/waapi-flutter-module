import 'package:equatable/equatable.dart';

class SocialAuthorizationEntity extends Equatable {
  final bool canViewProfiles;
  final bool canViewPosts;
  final bool canPostLike;
  final bool canPostComments;
  final bool canLikeComments;
  final bool canEditComments;
  final bool canPostFeed;
  final bool canAttachmentsPostComments;
  final bool canDownloadAttachmentsPostComments;
  final bool canViewSpacesMembers;
  final bool canCreatePost;

  const SocialAuthorizationEntity({
    this.canViewProfiles = false,
    this.canViewPosts = false,
    this.canPostLike = false,
    this.canPostComments = false,
    this.canLikeComments = false,
    this.canEditComments = false,
    this.canPostFeed = false,
    this.canAttachmentsPostComments = false,
    this.canDownloadAttachmentsPostComments = false,
    this.canViewSpacesMembers = false,
    this.canCreatePost = false,
  });

  @override
  List<Object> get props => [
        canViewProfiles,
        canViewPosts,
        canPostLike,
        canPostComments,
        canLikeComments,
        canEditComments,
        canPostFeed,
        canAttachmentsPostComments,
        canDownloadAttachmentsPostComments,
        canViewSpacesMembers,
        canCreatePost,
      ];
}
