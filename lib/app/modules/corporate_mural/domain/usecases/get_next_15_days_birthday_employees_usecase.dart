import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_next_15_days_birthday_employees_repository.dart';
import '../types/corporate_mural_domain_types.dart';

abstract class GetNext15DaysBirthdayEmployeesUsecase {
  GetNext15DaysBirthdayEmployeesUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  });
}

class GetNext15DaysBirthdayEmployeesUsecaseImpl implements GetNext15DaysBirthdayEmployeesUsecase {
  final GetNext15DaysBirthdayEmployeesRepository _getNext15DaysBirthdayEmployeesRepository;

  const GetNext15DaysBirthdayEmployeesUsecaseImpl({
    required GetNext15DaysBirthdayEmployeesRepository getNext15DaysBirthdayEmployeesRepository,
  }) : _getNext15DaysBirthdayEmployeesRepository = getNext15DaysBirthdayEmployeesRepository;

  @override
  GetNext15DaysBirthdayEmployeesUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  }) {
    return _getNext15DaysBirthdayEmployeesRepository.call(
      paginationRequirements: paginationRequirements,
      currentDate: currentDate,
      employeeId: employeeId,
    );
  }
}
