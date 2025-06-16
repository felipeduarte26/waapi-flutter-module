import 'package:equatable/equatable.dart';

import '../../../attachment/domain/entities/attachment_entity.dart';
import '../../enums/hyperlink_type_enum.dart';

class HyperlinkEntity extends Equatable {
  final String id;
  final String url;
  final String? label;
  final String? iconUrl;
  final AttachmentEntity? attachment;
  final HyperlinkTypeEnum type;
  final bool showInputScreen;

  const HyperlinkEntity({
    required this.id,
    required this.url,
    this.label,
    this.iconUrl,
    this.attachment,
    required this.type,
    required this.showInputScreen,
  });

  @override
  List<Object?> get props {
    return [
      id,
      url,
      label,
      iconUrl,
      attachment,
      type,
      showInputScreen,
    ];
  }
}
