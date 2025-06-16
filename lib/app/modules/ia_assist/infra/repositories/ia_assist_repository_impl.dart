import '../../../../core/types/either.dart';
import '../../domain/failures/ia_assist_failure.dart';
import '../../domain/repositories/ia_assist_repository.dart';
import '../../domain/types/ia_assist_domain_types.dart';
import '../datasources/ia_assist_datasource.dart';

class IAAssistRepositoryImpl implements IAAssistRepository {
  final IAAssistDatasource _iaAssistDatasource;

  IAAssistRepositoryImpl({
    required IAAssistDatasource iaAssistDatasource,
  }) : _iaAssistDatasource = iaAssistDatasource;

  @override
  IAAssistUsecaseCallback call({
    required String prompt,
    required double temperature,
  }) async {
    try {
      final text = await _iaAssistDatasource.call(
        prompt: prompt,
        temperature: temperature,
      );
      return right(text);
    } catch (error) {
      return left(
        IAAssistDatasourceFailure(
          message: error.toString(),
        ),
      );
    }
  }
}
