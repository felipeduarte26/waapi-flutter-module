import '../input_models/send_vacation_request_input_model.dart';
import '../repositories/send_vacation_request_repository.dart';
import '../types/vacations_domain_types.dart';

abstract class SendVacationRequestUsecase {
  SendVacationRequestUsecaseCallback call({
    required SendVacationRequestInputModel sendVacationRequestInputModel,
  });
}

class SendVacationRequestUsecaseImpl implements SendVacationRequestUsecase {
  final SendVacationRequestRepository _sendVacationRequestRepository;

  SendVacationRequestUsecaseImpl({
    required SendVacationRequestRepository sendVacationRequestRepository,
  }) : _sendVacationRequestRepository = sendVacationRequestRepository;

  @override
  SendVacationRequestUsecaseCallback call({
    required SendVacationRequestInputModel sendVacationRequestInputModel,
  }) {
    return _sendVacationRequestRepository.call(
      sendVacationRequestInputModel: sendVacationRequestInputModel,
    );
  }
}
