import '../../domain/input_models/edit_personal_documents_input_model.dart';

abstract class UpdatePersonalDocumentsDatasource {
  Future<void> call({
    required EditPersonalDocumentsInputModel editPersonalDocumentsInputModel,
  });
}
