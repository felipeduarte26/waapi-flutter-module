import '../types/profile_domain_types.dart';

abstract class GetPublicProfileRepository {
  GetPublicProfileUsecaseCallback call({
    required String userName,
  });
}
