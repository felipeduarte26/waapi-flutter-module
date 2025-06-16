import '../../domain/entities/personal_request_update_entity.dart';
import '../models/personal_request_update_model.dart';

class PersonalRequestUpdateEntityAdapter {
  PersonalRequestUpdateEntity fromModel({
    required PersonalRequestUpdateModel personalRequestUpdateModel,
  }) {
    return PersonalRequestUpdateEntity(
      id: personalRequestUpdateModel.id,
      date: personalRequestUpdateModel.date,
      status: personalRequestUpdateModel.status,
    );
  }
}
