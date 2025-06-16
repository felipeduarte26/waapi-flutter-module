import '../input_models/send_vacation_request_input_model.dart';
import '../types/vacations_domain_types.dart';

abstract class SendVacationRequestRepository {
  SendVacationRequestUsecaseCallback call({
    required SendVacationRequestInputModel sendVacationRequestInputModel,
  });
}
