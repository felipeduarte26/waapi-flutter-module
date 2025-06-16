import '../types/feedback_domain_types.dart';

abstract class SearchCompetencesRepository {
  SearchCompetencesUsecaseCallback call({
    required String competency,
  });
}
