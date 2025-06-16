import '../repositories/cancel_vacation_request_repository.dart';
import '../types/vacations_domain_types.dart';

abstract class CancelVacationRequestUsecase {
  CancelVacationRequestUsecaseCallback call({
    required String idVacation,
    required bool isApproved,
    required String employeeId,
  });
}

class CancelVacationRequestUsecaseImpl implements CancelVacationRequestUsecase {
  final CancelVacationRequestRepository _cancelVacationRequestRepository;

  const CancelVacationRequestUsecaseImpl({
    required CancelVacationRequestRepository cancelVacationRequestRepository,
  }) : _cancelVacationRequestRepository = cancelVacationRequestRepository;

  @override
  CancelVacationRequestUsecaseCallback call({
    required String idVacation,
    required bool isApproved,
    required String employeeId,
  }) {
    return _cancelVacationRequestRepository.call(
      idVacation: idVacation,
      isApproved: isApproved,
      employeeId: employeeId,
    );
  }
}
