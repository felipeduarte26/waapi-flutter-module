import '../types/ia_assist_domain_types.dart';

abstract class IAAssistRepository {
  IAAssistUsecaseCallback call({
    required String prompt,
    required double temperature,
  });
}
