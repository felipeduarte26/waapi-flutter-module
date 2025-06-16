import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_next_15_days_birthdays_company_repository.dart';
import '../types/corporate_mural_domain_types.dart';

abstract class GetNext15DaysBirthdaysCompanyUsecase {
  GetNext15DaysBirthdaysCompanyUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  });
}

class GetNext15DaysBirthdaysCompanyUsecaseImpl implements GetNext15DaysBirthdaysCompanyUsecase {
  final GetNext15DaysBirthdaysCompanyRepository _getNext15DaysBirthdaysCompanyRepository;

  const GetNext15DaysBirthdaysCompanyUsecaseImpl({
    required GetNext15DaysBirthdaysCompanyRepository getNext15DaysBirthdaysCompanyRepository,
  }) : _getNext15DaysBirthdaysCompanyRepository = getNext15DaysBirthdaysCompanyRepository;

  @override
  GetNext15DaysBirthdaysCompanyUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  }) {
    return _getNext15DaysBirthdaysCompanyRepository.call(
      paginationRequirements: paginationRequirements,
      currentDate: currentDate,
      employeeId: employeeId,
    );
  }
}
