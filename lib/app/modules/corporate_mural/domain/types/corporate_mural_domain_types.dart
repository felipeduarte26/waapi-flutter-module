import '../../../../core/types/either.dart';
import '../entities/birthday_employees_entity.dart';
import '../entities/employees_by_year_hire_entity.dart';
import '../failures/corporate_mural_failure.dart';

typedef GetNext15DaysBirthdayEmployeesUsecaseCallback = Future<Either<CorporateMuralFailure, BirthdayEmployeesEntity>>;
typedef GetNext15DaysBirthdaysCompanyUsecaseCallback
    = Future<Either<CorporateMuralFailure, List<EmployeesByYearHireEntity>>>;
