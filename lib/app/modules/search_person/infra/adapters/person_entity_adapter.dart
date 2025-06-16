import '../../domain/entities/person_entity.dart';
import '../models/person_model.dart';

class PersonEntityAdapter {
  PersonEntity fromModel({
    required PersonModel personModel,
  }) {
    return PersonEntity(
      employeeId: personModel.employeeId,
      name: personModel.name,
      username: personModel.username,
      linkPhoto: personModel.linkPhoto,
      jobPosition: personModel.jobPosition,
    );
  }
}
