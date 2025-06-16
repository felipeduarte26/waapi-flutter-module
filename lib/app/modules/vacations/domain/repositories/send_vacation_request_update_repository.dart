import '../input_models/send_vacation_request_update_input_model.dart';
import '../types/vacations_domain_types.dart';

abstract class SendVacationRequestUpdateRepository {
  SendVacationRequestUpdateUsecaseCallback call({
    required SendVacationRequestUpdateInputModel sendVacationRequestUpdateInputModel,
  });
}
