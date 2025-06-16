import '../types/vacations_domain_types.dart';

abstract class GetReportVacationRepository {
  GetReportVacationUsecaseCallback call({
    required String reportLink,
  });
}
