import 'package:equatable/equatable.dart';

import 'social_attachment_model.dart';
import 'social_comments_model.dart';
import 'social_group_model.dart';
import 'social_mention_model.dart';
import 'social_profile_model.dart';
import 'social_space_model.dart';

class SocialPostModel extends Equatable {
  final String id;
  final SocialProfileModel author;
  final SocialSpaceModel? space;
  final DateTime when;
  final DateTime? sticky;
  final bool read;
  final String text;
  final SocialAttachmentModel? attachment;
  final List<SocialAttachmentModel>? attachments;
  final List<SocialCommentsModel> comments;
  final int commentCount;
  final List<SocialProfileModel>? profilesThatLiked;
  final int likeCount;
  final bool gotMyLike;
  final List<SocialMentionModel>? mentions;
  final bool isAuthor;
  final List<SocialGroupModel>? groups;
  final bool approved;
  final bool complained;
  final bool isFixed;
  final bool blockedComment;

  const SocialPostModel({
    required this.id,
    required this.author,
    this.space,
    required this.when,
    this.sticky,
    this.read = false,
    required this.text,
    this.attachment,
    this.attachments,
    required this.comments,
    required this.commentCount,
    this.profilesThatLiked,
    required this.likeCount,
    this.gotMyLike = false,
    this.mentions,
    this.isAuthor = false,
    this.groups,
    this.approved = false,
    this.complained = false,
    this.isFixed = false,
    this.blockedComment = false,
  });

  @override
  List<Object?> get props {
    return [
      id,
      author,
      when,
      space,
      sticky,
      read,
      text,
      attachment,
      attachments,
      comments,
      commentCount,
      likeCount,
      gotMyLike,
      mentions,
      isAuthor,
      groups,
      approved,
      complained,
      isFixed,
      blockedComment,
    ];
  }
}
