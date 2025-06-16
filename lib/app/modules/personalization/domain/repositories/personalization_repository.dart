import '../types/personalization_domain_types.dart';

abstract class PersonalizationRepository {
  GetPersonalizationUsecaseCallback call();
}
