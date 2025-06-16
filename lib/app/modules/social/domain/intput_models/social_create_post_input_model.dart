import 'package:equatable/equatable.dart';

import 'social_attachment_input_model.dart';

class SocialCreatePostInputModel extends Equatable {
  final String text;
  final List<String>? groups;
  final String when;
  final String? space;
  final String profileId;
  final bool blockedComment;
  final List<SocialAttachmentInputModel>? attachments;

  const SocialCreatePostInputModel({
    required this.text,
    this.groups,
    required this.when,
    this.space,
    required this.profileId,
    this.blockedComment = false,
    this.attachments,
  });

  @override
  List<Object?> get props => [
        text,
        groups,
        when,
        space,
        profileId,
        blockedComment,
        attachments,
      ];
}
