import '../../../../core/types/either.dart';
import '../../../g5/domain/usecases/get_g5_connector_usecase.dart';
import '../failures/financial_data_failure.dart';
import '../repositories/get_earnings_reports_repository.dart';
import '../types/financial_data_domain_types.dart';

abstract class GetEarningsReportsUsecase {
  GetEarningsReportsUsecaseCallback call({
    required String registerNumber,
    required int companyNumber,
    required int year,
  });
}

class GetEarningsReportsUsecaseImpl implements GetEarningsReportsUsecase {
  final GetEarningsReportsRepository _getEarningsReportsRepository;
  final GetG5ConnectorUsecase _getG5ConnectorUsecase;

  GetEarningsReportsUsecaseImpl({
    required GetEarningsReportsRepository getEarningsReportsRepository,
    required GetG5ConnectorUsecase getG5ConnectorUsecase,
  })  : _getEarningsReportsRepository = getEarningsReportsRepository,
        _getG5ConnectorUsecase = getG5ConnectorUsecase;

  @override
  GetEarningsReportsUsecaseCallback call({
    required String registerNumber,
    required int companyNumber,
    required int year,
  }) async {
    final connector = await _getG5ConnectorUsecase.call();

    return connector.fold(
      (_) {
        return left(const FinancialDataDatasourceFailure());
      },
      (right) {
        return _getEarningsReportsRepository.call(
          companyNumber: companyNumber,
          registerNumber: registerNumber,
          year: year,
          connector: right,
        );
      },
    );
  }
}
