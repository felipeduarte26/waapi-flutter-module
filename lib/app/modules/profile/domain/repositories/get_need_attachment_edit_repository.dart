import '../types/profile_domain_types.dart';

abstract class GetNeedAttachmentEditRepository {
  GetNeedAttachmentEditUsecaseCallback call({
    required String role,
  });
}
