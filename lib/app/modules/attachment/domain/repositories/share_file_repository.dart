import '../types/attachment_domain_types.dart';

abstract class ShareFileRepository {
  ShareFileUsecaseCallback call({
    required String fileToShare,
  });
}
