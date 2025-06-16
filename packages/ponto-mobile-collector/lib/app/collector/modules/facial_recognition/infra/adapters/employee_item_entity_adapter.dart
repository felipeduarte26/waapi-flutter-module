import '../../domain/entities/employee_item_entity.dart';
import '../models/employee_item_model.dart';

class EmployeeItemEntityAdapter {
  EmployeeItemEntity fromModel({required EmployeeItemModel employeeItemModel}) {
    return EmployeeItemEntity(
      id: employeeItemModel.id,
      identifier:
          employeeItemModel.identifier.replaceAll('.', '').replaceAll('-', ''),
      name: employeeItemModel.name,
    );
  }
}
