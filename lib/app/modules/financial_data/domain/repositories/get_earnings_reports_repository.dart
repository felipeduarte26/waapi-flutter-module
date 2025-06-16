import '../types/financial_data_domain_types.dart';

abstract class GetEarningsReportsRepository {
  GetEarningsReportsUsecaseCallback call({
    required String registerNumber,
    required int companyNumber,
    required int year,
    required String connector,
  });
}
