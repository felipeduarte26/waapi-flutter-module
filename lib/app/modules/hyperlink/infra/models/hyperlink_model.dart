import 'package:equatable/equatable.dart';

import '../../../attachment/infra/models/attachment_model.dart';
import '../../enums/hyperlink_type_enum.dart';

class HyperlinkModel extends Equatable {
  final String id;
  final String url;
  final String? label;
  final String? iconUrl;
  final AttachmentModel? attachment;
  final HyperlinkTypeEnum type;
  final bool showInputScreen;

  const HyperlinkModel({
    required this.id,
    required this.url,
    required this.label,
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
