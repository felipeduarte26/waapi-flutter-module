import '../repositories/get_report_vacation_repository.dart';
import '../types/vacations_domain_types.dart';

abstract class GetReportVacationUsecase {
  GetReportVacationUsecaseCallback call({
    required String reportLink,
  });
}

class GetReportVacationUsecaseImpl implements GetReportVacationUsecase {
  final GetReportVacationRepository _getReportVacationRepository;

  const GetReportVacationUsecaseImpl({
    required GetReportVacationRepository getReportVacationRepository,
  }) : _getReportVacationRepository = getReportVacationRepository;

  @override
  GetReportVacationUsecaseCallback call({
    required String reportLink,
  }) {
    return _getReportVacationRepository.call(
      reportLink: reportLink,
    );
  }
}
