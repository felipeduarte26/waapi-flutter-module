import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/data_source_response_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/sync_logs_api_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/sync_logs_api_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/sync_logs_api_repository_impl.dart';

class MockLogsDatasource extends Mock implements SyncLogsApiDatasource {}

void main() {
  group('LogsRepositoryImpl', () {
    late MockLogsDatasource mockLogsDatasource;
    late SyncLogsApiRepository logsRepository;

    setUp(() {
      mockLogsDatasource = MockLogsDatasource();
      logsRepository =
          SyncLogsApiRepositoryImpl(syncLogsApiDatasource: mockLogsDatasource);
    });

    test('should call LogsDatasource with correct parameters', () async {
      var dataResponse =
          DataSourceResponseDto(success: true, message: 'succes');
      final Map<String, dynamic> jsonLogs = {'key': 'value'};
      when(() => mockLogsDatasource.call(jsonLogs: jsonLogs)).thenAnswer(
        (_) async => dataResponse,
      );

      final result = await logsRepository.call(jsonLogs: jsonLogs);

      verify(() => mockLogsDatasource.call(jsonLogs: jsonLogs)).called(1);
      expect(
        result,
        dataResponse,
      );
    });

    test('should return false when LogsDatasource returns false', () async {
      var dataResponse =
          DataSourceResponseDto(success: false, message: 'falied');
      final Map<String, dynamic> jsonLogs = {'key': 'value'};
      when(() => mockLogsDatasource.call(jsonLogs: jsonLogs)).thenAnswer(
        (_) async => dataResponse,
      );

      final result = await logsRepository.call(jsonLogs: jsonLogs);

      verify(() => mockLogsDatasource.call(jsonLogs: jsonLogs)).called(1);
      expect(result, dataResponse);
    });
  });
}
