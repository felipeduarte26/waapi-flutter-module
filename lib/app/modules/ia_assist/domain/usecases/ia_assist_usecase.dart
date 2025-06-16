import '../repositories/ia_assist_repository.dart';
import '../types/ia_assist_domain_types.dart';

abstract class IAAssistUsecase {
  IAAssistUsecaseCallback call({
    required String prompt,
    required double temperature,
  });
}

class IAAssistUsecaseImpl implements IAAssistUsecase {
  final IAAssistRepository _iaAssistRepository;

  IAAssistUsecaseImpl({
    required IAAssistRepository iaAssistRepository,
  }) : _iaAssistRepository = iaAssistRepository;

  @override
  IAAssistUsecaseCallback call({
    required String prompt,
    required double temperature,
  }) {
    return _iaAssistRepository.call(
      prompt: prompt,
      temperature: temperature,
    );
  }
}
