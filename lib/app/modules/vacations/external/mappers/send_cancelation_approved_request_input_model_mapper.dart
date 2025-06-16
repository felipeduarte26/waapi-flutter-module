import '../../domain/input_models/send_cancelation_approved_request_input_model.dart';

class SendCancelationApprovedRequestInputModelMapper {
  Map<String, dynamic> toMap({
    required SendCancelationApprovedRequestInputModel sendCancelationApprovedRequestInputModel,
  }) {
    return {
      'vacationScheduleToCancelId': sendCancelationApprovedRequestInputModel.vacationScheduleToCancelId,
      'employeeId': sendCancelationApprovedRequestInputModel.employeeId,
    };
  }
}
