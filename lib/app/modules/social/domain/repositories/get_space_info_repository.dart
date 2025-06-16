import '../types/social_domain_types.dart';

abstract class GetSpaceInfoRepository {
  GetSpaceInfoUsecaseCallback call({
    required String permaname,
  });
}
