import '../../domain/input_models/send_vacation_request_attachments_update_input_model.dart';

class SendVacationRequestAttachmentsUpdateInputModelMapper {
  Map<String, dynamic> toMap({
    required SendVacationRequestAttachmentsUpdateInputModel sendVacationRequestAttachmentUpdateInputModel,
  }) {
    return {
      'id': sendVacationRequestAttachmentUpdateInputModel.id,
      'name': sendVacationRequestAttachmentUpdateInputModel.name,
      'link': sendVacationRequestAttachmentUpdateInputModel.link,
      'personId': sendVacationRequestAttachmentUpdateInputModel.personId,
      'operation': sendVacationRequestAttachmentUpdateInputModel.operation,
    };
  }
}
