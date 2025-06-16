import '../types/profile_domain_types.dart';

abstract class SearchCountryRepository {
  SearchCountryUsecaseCallback call({
    required String country,
  });
}
