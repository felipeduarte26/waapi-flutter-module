import '../../infra/models/employee_item_model.dart';

class EmployeeItemModelMapper {
  EmployeeItemModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return EmployeeItemModel(
      id: map['id'],
      identifier: map['identifier'],
      name: map['name'],
    );
  }
}
