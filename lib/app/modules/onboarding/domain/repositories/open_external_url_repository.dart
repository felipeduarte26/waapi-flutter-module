import '../types/onboarding_domain_types.dart';

abstract class OpenExternalUrlRepository {
  OpenExternalUrlUsecaseCallback call({
    required String externalUrl,
  });
}
