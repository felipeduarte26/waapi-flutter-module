import '../../domain/entities/attachment_entity.dart';
import '../models/attachment_model.dart';

class AttachmentEntityAdapter {
  AttachmentEntity fromModel({
    required AttachmentModel model,
  }) {
    return AttachmentEntity(
      id: model.id,
      name: model.name,
      link: model.link,
      personId: model.personId,
    );
  }
}
