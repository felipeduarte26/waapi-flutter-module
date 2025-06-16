import '../types/profile_domain_types.dart';

abstract class SearchNationalityRepository {
  SearchNationalityUsecaseCallback call({
    required String nationality,
  });
}
