import '../../domain/input_models/dependent_dto_input_model.dart';
import 'attachments_input_model_mapper.dart';
import 'edit_dependents_input_model_mapper.dart';

class DependentDtoInputModelMapper {
  Map<String, dynamic> toMap({
    required DependentDtoInputModel dependentDtoInputModel,
  }) {
    return {
      'commentary': dependentDtoInputModel.commentary,
      'dependentId': dependentDtoInputModel.dependentId,
      'dependentDTO': EditDependentsInputModelMapper().toMap(
        editDependentsInputModel: dependentDtoInputModel.editDependentsInputModel,
      ),
      'attachments': dependentDtoInputModel.attachmentsInputModel.map((
        editAttachmentsInputModel,
      ) {
        return AttachmentsInputModelMapper().toMap(
          attachmentInputModel: editAttachmentsInputModel,
        );
      }).toList(),
      'requestType': dependentDtoInputModel.requestType,
    };
  }
}
