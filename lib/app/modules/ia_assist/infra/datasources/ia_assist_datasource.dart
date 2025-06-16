abstract class IAAssistDatasource {
  Future<String> call({
    required String prompt,
    required double temperature,
  });
}
