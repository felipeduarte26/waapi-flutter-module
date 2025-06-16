import '../../../../core/types/either.dart';
import '../../domain/failures/vacations_failure.dart';
import '../../domain/repositories/get_report_vacation_repository.dart';
import '../../domain/types/vacations_domain_types.dart';
import '../datasources/get_report_vacation_datasource.dart';

class GetReportVacationRepositoryImpl implements GetReportVacationRepository {
  final GetReportVacationDatasource _getReportVacationDatasource;

  const GetReportVacationRepositoryImpl({
    required GetReportVacationDatasource getReportVacationDatasource,
  }) : _getReportVacationDatasource = getReportVacationDatasource;

  @override
  GetReportVacationUsecaseCallback call({
    required String reportLink,
  }) async {
    try {
      final report = await _getReportVacationDatasource.call(
        reportLink: reportLink,
      );

      return right(report);
    } catch (error) {
      return left(const VacationsDatasourceFailure());
    }
  }
}
