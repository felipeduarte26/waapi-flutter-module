import '../types/attachment_domain_types.dart';

abstract class ShareStringRepository {
  ShareStringUsecaseCallback call({
    required String stringToShare,
  });
}
