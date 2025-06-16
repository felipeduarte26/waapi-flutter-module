import '../../../../core/types/either.dart';
import '../../domain/failures/financial_data_failure.dart';
import '../../domain/repositories/get_earnings_reports_repository.dart';
import '../../domain/types/financial_data_domain_types.dart';
import '../datasources/get_earnings_report_datasource.dart';

class GetEarningsReportsRepositoryImpl implements GetEarningsReportsRepository {
  final GetEarningsReportDatasource _getEarningsReportsDatasource;

  GetEarningsReportsRepositoryImpl({
    required GetEarningsReportDatasource getEarningsReportsDatasource,
  }) : _getEarningsReportsDatasource = getEarningsReportsDatasource;

  @override
  GetEarningsReportsUsecaseCallback call({
    required String registerNumber,
    required int companyNumber,
    required int year,
    required String connector,
  }) async {
    try {
      final report = await _getEarningsReportsDatasource.call(
        year: year,
        companyNumber: companyNumber,
        registerNumber: registerNumber,
        connector: connector,
      );

      var pdf = false;

      for (int i = 0; i < report.length - 3; i++) {
        if (report[i] == 37 && report[i + 1] == 80 && report[i + 2] == 68 && report[i + 3] == 70) {
          pdf = true;
          break;
        }
      }

      if (pdf) {
        return right(report);
      }

      return left(const FinancialDataDatasourceFailure());
    } catch (error) {
      return left(
        const FinancialDataDatasourceFailure(),
      );
    }
  }
}
