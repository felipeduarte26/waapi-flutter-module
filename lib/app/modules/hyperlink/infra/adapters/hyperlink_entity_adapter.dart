import '../../../attachment/infra/adapters/attachment_entity_adapter.dart';
import '../../domain/entities/hyperlink_entity.dart';
import '../models/hyperlink_model.dart';

class HyperlinkEntityAdapter {
  HyperlinkEntity fromModel({
    required HyperlinkModel hyperlinkModel,
  }) {
    return HyperlinkEntity(
      id: hyperlinkModel.id,
      label: hyperlinkModel.label,
      type: hyperlinkModel.type,
      url: hyperlinkModel.url,
      iconUrl: hyperlinkModel.iconUrl,
      attachment: hyperlinkModel.attachment != null
          ? AttachmentEntityAdapter().fromModel(
              model: hyperlinkModel.attachment!,
            )
          : null,
      showInputScreen: hyperlinkModel.showInputScreen,
    );
  }
}
