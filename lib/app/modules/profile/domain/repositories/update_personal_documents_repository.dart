import '../input_models/edit_personal_documents_input_model.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalDocumentsRepository {
  UpdatePersonalDocumentsUsecaseCallback call({
    required EditPersonalDocumentsInputModel editPersonalDocumentsInputModel,
  });
}
