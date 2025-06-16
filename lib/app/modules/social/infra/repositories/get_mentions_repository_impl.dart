
import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_mentions_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_profile_entity_adapter.dart';
import '../datasources/get_mentions_datasource.dart';

class GetMentionsRepositoryImpl implements GetMentionsRepository {
  final GetMentionsDatasource _getMentionsDatasource;
 
  final SocialProfileEntityAdapter _mentionsEntityAdapter;

  const GetMentionsRepositoryImpl({
    required GetMentionsDatasource getMentionsDatasource,
    
    required SocialProfileEntityAdapter mentionsEntityAdapter,
  })  : _getMentionsDatasource = getMentionsDatasource,
        
        _mentionsEntityAdapter = mentionsEntityAdapter;

  @override
  GetMentionsUsecaseCallback call({
    required String query,
  }) async {
    try {
      final mentionsModel = await _getMentionsDatasource.call(
        query: query,
      );

      final mentionsEntity = mentionsModel
          .map(
            (mention) => _mentionsEntityAdapter.fromModel(
              authorModel: mention,
            ),
          )
          .toList();

      return right(mentionsEntity);
    } catch (error) {


      return left(SocialDatasourceFailure());
    }
  }
}
