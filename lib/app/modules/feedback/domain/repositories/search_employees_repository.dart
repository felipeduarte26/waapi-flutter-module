import '../types/feedback_domain_types.dart';

abstract class SearchEmployeesRepository {
  SearchEmployeesUsecaseCallback call({
    required String search,
  });
}
