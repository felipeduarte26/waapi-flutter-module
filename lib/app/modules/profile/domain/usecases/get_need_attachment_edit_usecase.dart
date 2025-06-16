import '../repositories/get_need_attachment_edit_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetNeedAttachmentEditUsecase {
  GetNeedAttachmentEditUsecaseCallback call({
    required String role,
  });
}

class GetNeedAttachmentEditUsecaseImpl implements GetNeedAttachmentEditUsecase {
  final GetNeedAttachmentEditRepository _getNeedAttachmentEditRepository;

  const GetNeedAttachmentEditUsecaseImpl({
    required GetNeedAttachmentEditRepository getNeedAttachmentEditRepository,
  }) : _getNeedAttachmentEditRepository = getNeedAttachmentEditRepository;

  @override
  GetNeedAttachmentEditUsecaseCallback call({
    required String role,
  }) {
    return _getNeedAttachmentEditRepository.call(
      role: role,
    );
  }
}
