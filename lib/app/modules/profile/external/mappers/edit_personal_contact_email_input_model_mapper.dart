import '../../domain/input_models/edit_personal_contact_email_input_model.dart';

class EditPersonalContactEmailInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalContactEmailInputModel editPersonalContactEmailInputModel,
  }) {
    return {
      'id': editPersonalContactEmailInputModel.id,
      'email': editPersonalContactEmailInputModel.email,
      'type': editPersonalContactEmailInputModel.type,
      'originalType': editPersonalContactEmailInputModel.originalType,
      'personRequestUpdateType': editPersonalContactEmailInputModel.personRequestUpdateType,
    };
  }
}
