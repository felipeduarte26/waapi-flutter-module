import '../../../../core/types/either.dart';
import '../../domain/failures/moods_failure.dart';
import '../../domain/repositories/get_moods_pulse_link_repository.dart';
import '../../domain/types/moods_domain_types.dart';
import '../datasources/get_moods_pulse_link_datasource.dart';

class GetMoodsPulseLinkRepositoryImpl implements GetMoodsPulseLinkRepository {
  final GetMoodsPulseLinkDatasource _getMoodsPulseLinkDatasource;

  const GetMoodsPulseLinkRepositoryImpl({
    required GetMoodsPulseLinkDatasource getMoodsPulseLinkDatasource,
  }) : _getMoodsPulseLinkDatasource = getMoodsPulseLinkDatasource;

  @override
  GetMoodsPulseLinkUsecaseCallback call({
    required String userId,
  }) async {
    try {
      final pulseLink = await _getMoodsPulseLinkDatasource.call(
        userId: userId,
      );

      return right(pulseLink);
    } catch (error) {
      return left(MoodsDatasourceFailure());
    }
  }
}
