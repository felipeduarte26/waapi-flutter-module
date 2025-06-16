import '../../domain/input_models/send_vacation_request_input_model.dart';
import 'send_vacation_request_attachments_input_model_mapper.dart';

class SendVacationRequestInputModelMapper {
  Map<String, dynamic> toMap({
    required SendVacationRequestInputModel sendVacationRequestInputModel,
  }) {
    return {
      'integrationErrorMessage': sendVacationRequestInputModel.integrationErrorMessage,
      'startDate': sendVacationRequestInputModel.startDate,
      'vacationDays': sendVacationRequestInputModel.vacationsDays,
      'has13thSalaryAdvance': sendVacationRequestInputModel.has13thSalaryAdvance,
      'vacationBonusDays': sendVacationRequestInputModel.vacationBonusDays,
      'commentary': sendVacationRequestInputModel.commentary,
      'approverCommentary': sendVacationRequestInputModel.approverCommentary,
      'attachments': sendVacationRequestInputModel.attachments?.map((sendVacationRequestAttachmentsInputModel) {
        return SendVacationRequestAttachmentsInputModelMapper().toMap(
          sendVacationRequestAttachmentInputModel: sendVacationRequestAttachmentsInputModel,
        );
      }).toList(),
      'vacationPeriodId': sendVacationRequestInputModel.vacationPeriodId,
      'employeeId': sendVacationRequestInputModel.employeeId,
    };
  }
}
