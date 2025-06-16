import '../types/profile_domain_types.dart';

abstract class GetProfileRepository {
  GetProfileUsecaseCallback call({
    required String employeeId,
    required String personId,
  });
}
