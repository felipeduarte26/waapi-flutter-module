import '../../domain/input_models/edit_personal_data_input_model.dart';
import 'attachments_input_model_mapper.dart';
import 'edit_personal_data_personal_dto_input_model_mapper.dart';

class EditPersonalDataInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalDataInputModel editPersonalDataInputModel,
  }) {
    return {
      'type': 'PERSONAL_DATA',
      'commentary': editPersonalDataInputModel.commentary,
      'attachments': editPersonalDataInputModel.attachments?.map((editPersonalDataAttachmentsInputModel) {
        return AttachmentsInputModelMapper().toMap(
          attachmentInputModel: editPersonalDataAttachmentsInputModel,
        );
      }).toList(),
      'personalDTO': EditPersonalDataPersonalDTOInputModelMapper().toMap(
        editPersonalDataInputModel: editPersonalDataInputModel.personalDTO,
      ),
    };
  }
}
