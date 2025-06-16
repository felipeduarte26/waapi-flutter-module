import '../models/pagination_employee_item_model.dart';

abstract class GetEmployeesToFacialRegistrationDatasource {
  Future<PaginationEmployeeItemModel> call({
    String? name,
    required int pageNumber,
    required int pageSize,
    required String token,
  });
}
