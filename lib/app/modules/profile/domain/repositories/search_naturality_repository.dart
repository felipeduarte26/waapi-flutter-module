import '../types/profile_domain_types.dart';

abstract class SearchNaturalityRepository {
  SearchNaturalityUsecaseCallback call({
    required String naturality,
  });
}
