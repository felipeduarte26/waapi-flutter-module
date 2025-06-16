abstract class GetEarningsReportDatasource {
  Future<List<int>> call({
    required int year,
    required String registerNumber,
    required int companyNumber,
    required String connector,
  });
}
