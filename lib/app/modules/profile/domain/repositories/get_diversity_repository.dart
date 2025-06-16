import '../types/profile_domain_types.dart';

abstract class GetDiversityRepository {
  GetDiversityUsecaseCallback call({
    required String personId,
  });
}
