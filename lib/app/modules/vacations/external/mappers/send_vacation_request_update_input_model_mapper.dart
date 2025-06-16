import '../../domain/input_models/send_vacation_request_update_input_model.dart';
import 'send_vacation_request_attachments_update_input_model_mapper.dart';

class SendVacationRequestUpdateInputModelMapper {
  Map<String, dynamic> toMap({
    required SendVacationRequestUpdateInputModel sendVacationRequestUpdateInputModel,
  }) {
    return {
      'id': sendVacationRequestUpdateInputModel.id,
      'startDate': sendVacationRequestUpdateInputModel.startDate,
      'vacationDays': sendVacationRequestUpdateInputModel.vacationsDays,
      'has13thSalaryAdvance': sendVacationRequestUpdateInputModel.has13thSalaryAdvance,
      'vacationBonusDays': sendVacationRequestUpdateInputModel.vacationBonusDays,
      'commentary': sendVacationRequestUpdateInputModel.commentary,
      'attachments':
          sendVacationRequestUpdateInputModel.attachments?.map((sendVacationRequestAttachmentUpdateInputModel) {
        return SendVacationRequestAttachmentsUpdateInputModelMapper().toMap(
          sendVacationRequestAttachmentUpdateInputModel: sendVacationRequestAttachmentUpdateInputModel,
        );
      }).toList(),
      'vacationPeriodId': sendVacationRequestUpdateInputModel.vacationPeriodId,
      'employeeId': sendVacationRequestUpdateInputModel.employeeId,
    };
  }
}
