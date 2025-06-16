import '../repositories/open_external_url_repository.dart';
import '../types/onboarding_domain_types.dart';

abstract class OpenExternalUrlUsecase {
  OpenExternalUrlUsecaseCallback call({
    required String externalUrl,
  });
}

class OpenExternalUrlUsecaseImpl implements OpenExternalUrlUsecase {
  final OpenExternalUrlRepository _openExternalUrlRepository;

  const OpenExternalUrlUsecaseImpl({
    required OpenExternalUrlRepository openExternalUrlRepository,
  }) : _openExternalUrlRepository = openExternalUrlRepository;

  @override
  OpenExternalUrlUsecaseCallback call({
    required String externalUrl,
  }) {
    return _openExternalUrlRepository.call(
      externalUrl: externalUrl,
    );
  }
}
