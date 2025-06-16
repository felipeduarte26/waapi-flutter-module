import '../../domain/input_models/send_vacation_request_attachments_input_model.dart';

class SendVacationRequestAttachmentsInputModelMapper {
  Map<String, dynamic> toMap({
    required SendVacationRequestAttachmentsInputModel sendVacationRequestAttachmentInputModel,
  }) {
    return {
      'id': sendVacationRequestAttachmentInputModel.id,
      'name': sendVacationRequestAttachmentInputModel.name,
      'link': sendVacationRequestAttachmentInputModel.link,
      'personId': sendVacationRequestAttachmentInputModel.personId,
      'operation': sendVacationRequestAttachmentInputModel.operation,
    };
  }
}
