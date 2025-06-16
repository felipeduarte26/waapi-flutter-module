import 'package:equatable/equatable.dart';

import 'social_attachment_entity.dart';
import 'social_mention_entity.dart';
import 'social_profile_entity.dart';

class SocialCommentsEntity extends Equatable {
  final String id;
  final SocialProfileEntity author;
  final DateTime when;
  final String text;
  final List<SocialMentionEntity>? mentions;
  final int likeCount;
  final bool gotMyLike;
  final List<SocialProfileEntity>? profilesThatLiked;
  final String? parent;
  final List<SocialCommentsEntity>? children;
  final bool complained;
  final bool isDenounciator;
  final bool isAuthor;
  final bool edited;
  final SocialAttachmentEntity? attachment;

  const SocialCommentsEntity({
    required this.id,
    required this.author,
    required this.when,
    required this.text,
    this.mentions,
    required this.likeCount,
    required this.gotMyLike,
    this.profilesThatLiked,
    this.parent,
    this.children,
    this.complained = false,
    this.isDenounciator = false,
    this.isAuthor = false,
    this.edited = false,
    this.attachment,
  });

  @override
  List<Object?> get props => [
        id,
        author,
        when,
        text,
        mentions,
        likeCount,
        gotMyLike,
        profilesThatLiked,
        parent,
        children,
        complained,
        isDenounciator,
        isAuthor,
        edited,
        attachment,
      ];

  SocialCommentsEntity copyWith({
    String? id,
    SocialProfileEntity? author,
    DateTime? when,
    String? text,
    List<SocialMentionEntity>? mentions,
    int? likeCount,
    bool? gotMyLike,
    List<SocialProfileEntity>? profilesThatLiked,
    String? parent,
    List<SocialCommentsEntity>? children,
    bool? complained,
    bool? isDenounciator,
    bool? isAuthor,
    bool? edited,
    SocialAttachmentEntity? attachment,
  }) {
    return SocialCommentsEntity(
      id: id ?? this.id,
      author: author ?? this.author,
      when: when ?? this.when,
      text: text ?? this.text,
      mentions: mentions ?? this.mentions,
      likeCount: likeCount ?? this.likeCount,
      gotMyLike: gotMyLike ?? this.gotMyLike,
      profilesThatLiked: profilesThatLiked ?? this.profilesThatLiked,
      parent: parent ?? this.parent,
      children: children ?? this.children,
      complained: complained ?? this.complained,
      isDenounciator: isDenounciator ?? this.isDenounciator,
      isAuthor: isAuthor ?? this.isAuthor,
      edited: edited ?? this.edited,
      attachment: attachment ?? this.attachment,
    );
  }
}
