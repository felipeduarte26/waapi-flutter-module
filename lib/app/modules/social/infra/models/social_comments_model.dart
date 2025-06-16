import 'package:equatable/equatable.dart';

import 'social_attachment_model.dart';
import 'social_mention_model.dart';
import 'social_profile_model.dart';

class SocialCommentsModel extends Equatable {
  final String id;
  final SocialProfileModel author;
  final DateTime when;
  final String text;
  final List<SocialMentionModel>? mentions;
  final int likeCount;
  final bool gotMyLike;
  final List<SocialProfileModel>? profilesThatLiked;
  final String? parent;
  final List<SocialCommentsModel>? children;
  final bool complained;
  final bool isDenounciator;
  final bool isAuthor;
  final bool edited;
  final SocialAttachmentModel? attachment;

  const SocialCommentsModel({
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
}
