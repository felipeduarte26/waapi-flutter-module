import '../types/vacations_domain_types.dart';

abstract class GetVacationsRepository {
  GetVacationsUsecaseCallback call({
    required String employeeId,
  });
}
