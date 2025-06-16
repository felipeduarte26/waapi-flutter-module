import '../entities/pagination_employee_item_entity.dart';

abstract class GetEmployeesToFacialRegistrationRepository {
  Future<PaginationEmployeeItemEntity> call({
    String? name,
    required int pageNumber,
    required int pageSize,
    required String token,
  });
}
