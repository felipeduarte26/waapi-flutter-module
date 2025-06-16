import '../types/profile_domain_types.dart';

abstract class SearchEthnicityRepository {
  SearchEthnicityUsecaseCallback call({
    required String ethnicity,
  });
}
