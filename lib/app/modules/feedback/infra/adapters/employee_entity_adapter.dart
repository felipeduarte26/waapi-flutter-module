import '../../domain/entities/employee_entity.dart';
import '../models/employee_model.dart';

class EmployeeEntityAdapter {
  EmployeeEntity fromModel({
    required EmployeeModel model,
  }) {
    return EmployeeEntity(
      id: model.id,
      name: model.name,
      username: model.username,
      nickname: model.nickname,
      photoUrl: model.photoUrl,
    );
  }
}
