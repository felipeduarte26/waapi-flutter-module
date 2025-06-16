import 'package:equatable/equatable.dart';

import 'social_attachment_entity.dart';
import 'social_comments_entity.dart';
import 'social_group_entity.dart';
import 'social_mention_entity.dart';
import 'social_profile_entity.dart';
import 'social_space_entity.dart';

class SocialPostEntity extends Equatable {
  final String id;
  final SocialProfileEntity author;
  final SocialSpaceEntity? space;
  final DateTime? when;
  final DateTime? sticky;
  final bool read;
  final String text;
  final SocialAttachmentEntity? attachment;
  final List<SocialAttachmentEntity>? attachments;
  final List<SocialCommentsEntity> comments;
  final int commentCount;
  final List<SocialProfileEntity>? profilesThatLiked;
  final int likeCount;
  final bool gotMyLike;
  final List<SocialMentionEntity>? mentions;
  final bool isAuthor;
  final List<SocialGroupEntity>? groups;
  final bool approved;
  final bool complained;
  final bool isFixed;
  final bool blockedComment;

  const SocialPostEntity({
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

  SocialPostEntity copyWith({
    String? id,
    SocialProfileEntity? author,
    SocialSpaceEntity? space,
    DateTime? when,
    DateTime? sticky,
    bool? read,
    String? text,
    SocialAttachmentEntity? attachment,
    List<SocialAttachmentEntity>? attachments,
    List<SocialCommentsEntity>? comments,
    int? commentCount,
    List<SocialProfileEntity>? profilesThatLiked,
    int? likeCount,
    bool? gotMyLike,
    List<SocialMentionEntity>? mentions,
    bool? isAuthor,
    List<SocialGroupEntity>? groups,
    bool? approved,
    bool? complained,
    bool? isFixed,
    bool? blockedComment,
  }) {
    return SocialPostEntity(
      id: id ?? this.id,
      author: author ?? this.author,
      space: space ?? this.space,
      when: when ?? this.when,
      sticky: sticky ?? this.sticky,
      read: read ?? this.read,
      text: text ?? this.text,
      attachment: attachment ?? this.attachment,
      attachments: attachments ?? this.attachments,
      comments: comments ?? this.comments,
      commentCount: commentCount ?? this.commentCount,
      profilesThatLiked: profilesThatLiked ?? this.profilesThatLiked,
      likeCount: likeCount ?? this.likeCount,
      gotMyLike: gotMyLike ?? this.gotMyLike,
      mentions: mentions ?? this.mentions,
      isAuthor: isAuthor ?? this.isAuthor,
      groups: groups ?? this.groups,
      approved: approved ?? this.approved,
      complained: complained ?? this.complained,
      isFixed: isFixed ?? this.isFixed,
      blockedComment: blockedComment ?? this.blockedComment,
    );
  }

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
