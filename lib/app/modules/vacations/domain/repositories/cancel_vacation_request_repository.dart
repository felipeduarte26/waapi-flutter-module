import '../types/vacations_domain_types.dart';

abstract class CancelVacationRequestRepository {
  CancelVacationRequestUsecaseCallback call({
    required String idVacation,
    required bool isApproved,
    required String employeeId,
  });
}
