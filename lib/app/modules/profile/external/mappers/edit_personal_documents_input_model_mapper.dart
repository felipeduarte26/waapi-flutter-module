import '../../domain/input_models/edit_personal_documents_input_model.dart';
import 'attachments_input_model_mapper.dart';
import 'edit_personal_documents_dto_input_model_mapper.dart';

class EditPersonalDocumentsInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalDocumentsInputModel editPersonalDocumentsInputModel,
  }) {
    return {
      'type': 'DOCUMENT',
      'attachments': editPersonalDocumentsInputModel.attachments?.map((editPersonalDocumentsAttachmentsInputModel) {
        return AttachmentsInputModelMapper().toMap(
          attachmentInputModel: editPersonalDocumentsAttachmentsInputModel,
        );
      }).toList(),
      'documents': EditPersonalDocumentsDtoInputModelMapper().toMap(
        inputModel: editPersonalDocumentsInputModel.documents,
      ),
    };
  }
}
