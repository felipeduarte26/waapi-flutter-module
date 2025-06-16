import 'package:flutter/material.dart';

import '../../domain/entities/social_attachment_entity.dart';
import '../../enums/file_type_enum.dart';
import 'social_post_attachment_card_widget.dart';
import 'social_post_image_carousel_widget.dart';

class SocialPostAttachmentsWidget extends StatefulWidget {
  final String authorName;
  final FileTypeEnum fileType;
  final List<SocialAttachmentEntity> attachments;

  const SocialPostAttachmentsWidget({
    super.key,
    required this.attachments,
    required this.fileType,
    required this.authorName,
  });

  @override
  State<SocialPostAttachmentsWidget> createState() => _SocialPostAttachmentsWidgetState();
}

class _SocialPostAttachmentsWidgetState extends State<SocialPostAttachmentsWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.fileType == FileTypeEnum.image) {
      return SocialPostImageCarouselWidget(
        imageUrls: _getImages(widget.attachments),
        imageUserName: widget.authorName,
      );
    }
    return SocialPostAttachmentCardWidget(
      attachment: widget.attachments.first,
    );
  }

  List<String> _getImages(List<SocialAttachmentEntity> list) {
    return list.map((e) => e.fileUrl).toList();
  }
}
