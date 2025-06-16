import '../../../../core/types/either.dart';
import '../entities/social_search_content_entity.dart';
import '../failures/social_failure.dart';
import '../repositories/get_social_search_content_respository.dart';
import '../types/social_domain_types.dart';

abstract class GetSocialSearchContentUsecase {
  GetSocialSearchContentUsecaseCallback call({
    required String query,
    required int from,
    int maxRequests = 4,
    int batchSize = 5,
  });
}

class GetSocialSearchContentUsecaseImpl implements GetSocialSearchContentUsecase {
  final GetSocialSearchContentRepository _getSocialSearchContentRepository;

  const GetSocialSearchContentUsecaseImpl({
    required GetSocialSearchContentRepository socialSearchContentRepository,
  }) : _getSocialSearchContentRepository = socialSearchContentRepository;

  @override
  GetSocialSearchContentUsecaseCallback call({
    required String query,
    required int from,
    int maxRequests = 1,
    int batchSize = 5,
  }) async {
    List<Future<Either<SocialFailure, SocialSearchContentEntity>>> requests = [];

    for (int i = 0; i < maxRequests; i++) {
      int offset = from + (i * batchSize);
      requests.add(_getSocialSearchContentRepository.call(query: query, from: offset));
    }

    Future<Either<SocialFailure, SocialSearchContentEntity>> futureResult = Future.wait(requests).then((results) {
      List<SocialSearchContentEntity> successfulResults = [];

      for (var result in results) {
        result.fold(
          (failure) => null,
          (success) => successfulResults.add(success),
        );
      }

      if (successfulResults.isNotEmpty) {
        return right(SocialSearchContentEntity.merge(successfulResults));
      }

      return left(SocialSearchFailure());
    });

    return futureResult;
  }
}
