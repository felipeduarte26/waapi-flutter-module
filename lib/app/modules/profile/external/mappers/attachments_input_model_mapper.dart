import '../../domain/input_models/attachments_input_model.dart';

class AttachmentsInputModelMapper {
  Map<String, dynamic> toMap({
    required AttachmentsInputModel attachmentInputModel,
  }) {
    return {
      'id': attachmentInputModel.id,
      'name': attachmentInputModel.name,
      'link': attachmentInputModel.link,
      'personId': attachmentInputModel.personId,
      'operation': attachmentInputModel.operation,
    };
  }
}
