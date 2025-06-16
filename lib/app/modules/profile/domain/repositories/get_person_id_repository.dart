import '../types/profile_domain_types.dart';

abstract class GetPersonIdRepository {
  GetPersonIdUsecaseCallback call({
    required String employeeId,
  });
}
