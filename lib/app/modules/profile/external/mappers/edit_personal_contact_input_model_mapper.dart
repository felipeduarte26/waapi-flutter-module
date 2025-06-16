import '../../domain/input_models/edit_personal_contact_input_model.dart';
import 'attachments_input_model_mapper.dart';
import 'edit_personal_contact_dto_input_model_mapper.dart';

class EditPersonalContactInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalContactInputModel editPersonalContactInputModel,
  }) {
    return {
      'id': editPersonalContactInputModel.id,
      'type': 'CONTACT',
      'commentary': editPersonalContactInputModel.commentary,
      'attachments': editPersonalContactInputModel.attachments?.map((editPersonalDataAttachmentsInputModel) {
        return AttachmentsInputModelMapper().toMap(
          attachmentInputModel: editPersonalDataAttachmentsInputModel,
        );
      }).toList(),
      'contactDTO': EditPersonalContactDtoInputModelMapper().toMap(
        editPersonalContactDtoInputModel: editPersonalContactInputModel.contactDTO,
      ),
    };
  }
}
