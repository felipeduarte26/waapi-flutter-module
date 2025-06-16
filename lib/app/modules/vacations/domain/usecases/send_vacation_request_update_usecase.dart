import '../input_models/send_vacation_request_update_input_model.dart';
import '../repositories/send_vacation_request_update_repository.dart';
import '../types/vacations_domain_types.dart';

abstract class SendVacationRequestUpdateUseCase {
  SendVacationRequestUpdateUsecaseCallback call({
    required SendVacationRequestUpdateInputModel sendVacationRequestUpdateInputModel,
  });
}

class SendVacationRequestUpdateUsecaseImpl implements SendVacationRequestUpdateUseCase {
  final SendVacationRequestUpdateRepository _sendVacationRequestUpdateRepository;

  SendVacationRequestUpdateUsecaseImpl({
    required SendVacationRequestUpdateRepository sendVacationRequestUpdateRepository,
  }) : _sendVacationRequestUpdateRepository = sendVacationRequestUpdateRepository;

  @override
  SendVacationRequestUpdateUsecaseCallback call({
    required SendVacationRequestUpdateInputModel sendVacationRequestUpdateInputModel,
  }) {
    return _sendVacationRequestUpdateRepository.call(
      sendVacationRequestUpdateInputModel: sendVacationRequestUpdateInputModel,
    );
  }
}
