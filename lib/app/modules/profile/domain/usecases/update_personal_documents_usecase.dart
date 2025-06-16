import '../input_models/edit_personal_documents_input_model.dart';
import '../repositories/update_personal_documents_repository.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalDocumentsUsecase {
  UpdatePersonalDocumentsUsecaseCallback call({
    required EditPersonalDocumentsInputModel editPersonalDocumentsInputModel,
  });
}

class UpdatePersonalDocumentsUsecaseImpl implements UpdatePersonalDocumentsUsecase {
  final UpdatePersonalDocumentsRepository _updatePersonalDocumentsRepository;

  const UpdatePersonalDocumentsUsecaseImpl({
    required UpdatePersonalDocumentsRepository updatePersonalDocumentsRepository,
  }) : _updatePersonalDocumentsRepository = updatePersonalDocumentsRepository;

  @override
  UpdatePersonalDocumentsUsecaseCallback call({
    required EditPersonalDocumentsInputModel editPersonalDocumentsInputModel,
  }) {
    return _updatePersonalDocumentsRepository.call(
      editPersonalDocumentsInputModel: editPersonalDocumentsInputModel,
    );
  }
}
