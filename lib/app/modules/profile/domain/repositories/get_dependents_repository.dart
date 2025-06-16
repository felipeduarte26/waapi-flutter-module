import '../types/profile_domain_types.dart';

abstract class GetDependentsRepository {
  GetDependentsUsecaseCallback call({
    required String employeeId,
  });
}
