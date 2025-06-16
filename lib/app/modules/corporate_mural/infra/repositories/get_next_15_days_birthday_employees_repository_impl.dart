import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/corporate_mural_failure.dart';
import '../../domain/repositories/get_next_15_days_birthday_employees_repository.dart';
import '../../domain/types/corporate_mural_domain_types.dart';
import '../adapters/birthday_employees_model_adapter.dart';
import '../datasources/get_next_15_days_birthday_employees_datasource.dart';

class GetNext15DaysBirthdayEmployeesRepositoryImpl implements GetNext15DaysBirthdayEmployeesRepository {
  final GetNext15DaysBirthdayEmployeesDatasource _getNext15DaysBirthdayEmployeesDatasource;
  final BirthdayEmployeesModelAdapter _birthdayEmployeesModelAdapter;

  const GetNext15DaysBirthdayEmployeesRepositoryImpl({
    required GetNext15DaysBirthdayEmployeesDatasource getNext15DaysBirthdayEmployeesDatasource,
    required BirthdayEmployeesModelAdapter birthdayEmployeesModelAdapter,
  })  : _getNext15DaysBirthdayEmployeesDatasource = getNext15DaysBirthdayEmployeesDatasource,
        _birthdayEmployeesModelAdapter = birthdayEmployeesModelAdapter;

  @override
  GetNext15DaysBirthdayEmployeesUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  }) async {
    try {
      final birthdayEmployeesModel = await _getNext15DaysBirthdayEmployeesDatasource.call(
        paginationRequirements: paginationRequirements,
        currentDate: currentDate,
        employeeId: employeeId,
      );

      if (birthdayEmployeesModel == null) {
        return left(const NoBirthdayEmployeesFoundFailure());
      }

      final birthdayEmployeesEntity = _birthdayEmployeesModelAdapter.fromModel(
        birthdayEmployeesModel: birthdayEmployeesModel,
      );

      return right(birthdayEmployeesEntity);
    } catch (error) {
      return left(const CorporateMuralDatasourceFailure());
    }
  }
}
