import '../../domain/input_models/edit_personal_address_input_model.dart';
import 'attachments_input_model_mapper.dart';
import 'edit_personal_address_dto_input_model_mapper.dart';

class EditPersonalAddressInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalAddressInputModel editPersonalAddressInputModel,
  }) {
    return {
      'type': 'ADDRESS',
      'attachments': editPersonalAddressInputModel.attachments?.map((editAttachmentsInputModel) {
        return AttachmentsInputModelMapper().toMap(
          attachmentInputModel: editAttachmentsInputModel,
        );
      }).toList(),
      'addresses': editPersonalAddressInputModel.addresses?.map((editPersonalAddressInputModel) {
        return EditPersonalAddressDTOInputModelMapper().toMap(
          editPersonalAddressInputModel: editPersonalAddressInputModel,
        );
      }).toList(),
      'updateDate': editPersonalAddressInputModel.updateDate,
    };
  }
}
