import '../types/hyperlink_domain_types.dart';

abstract class GetHyperlinksRepository {
  GetHyperlinksUsecaseCallback call({
    required String employeeId,
    required String userRoleId,
  });
}
